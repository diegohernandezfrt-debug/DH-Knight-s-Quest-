extends CharacterBody2D

@export var speed := 200.0
@export var jump_force := -450.0
@export var max_health := 3

var current_health := 3
var can_take_damage := true
var facing_direction := 1
var spawn_position : Vector2
var coins := 0
var hit_enemies := []

var is_attacking := false

@export var knockback_force_x := 400.0
@export var knockback_force_y := -300.0

var gravity = ProjectSettings.get_setting(
	"physics/2d/default_gravity"
)

@onready var sprite = $AnimatedSprite2D
@onready var damage_timer = $DamageTimer
@onready var attack_area = $AttackArea
@onready var attack_timer = $AttackTimer

var respawn_position: Vector2

func _ready():
	await get_tree().process_frame

	if GameManager.checkpoint_level == GameManager.current_level \
	and GameManager.checkpoint_position != Vector2.ZERO:

		global_position = GameManager.checkpoint_position
	else:
		global_position = GameManager.level_spawn_position

	respawn_position = global_position
	current_health = max_health

func take_damage(amount, source_position):
	if not can_take_damage:
		return

	can_take_damage = false
	damage_timer.start()

	var direction = sign(
		global_position.x - source_position.x
	)

	velocity.x = direction * knockback_force_x
	velocity.y = knockback_force_y

	GameManager.damage_player(amount)
	print(
		"Vida GameManager: ",
		GameManager.player_health
	)
	AudioManager.play_sound(AudioManager.hurt_player)

	if GameManager.player_health <= 0:
		die()

func die():
	GameManager.register_death()
	GameManager.player_health = 0
	GameManager.health_changed.emit(
		GameManager.player_health
	)

	GameManager.game_over.emit()
	print("Jugador muerto")

func _physics_process(delta):
	if not GameManager.is_playing():
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	var direction = Input.get_axis(
		"ui_left",
		"ui_right"
	)

	if direction != 0:
		facing_direction = direction
		sprite.flip_h = direction < 0

	if not is_attacking:
		velocity.x = direction * speed
	else:
		velocity.x = 0

	if Input.is_action_just_pressed("Jump") \
	and is_on_floor():
		velocity.y = jump_force
		AudioManager.play_sound(AudioManager.jump_sound)

	if Input.is_action_just_pressed("Attack"):
		attack()

	if not is_attacking:
		if not is_on_floor():
			if sprite.animation != "jump":
				sprite.play("jump")
		elif direction != 0:

			if sprite.animation != "run":
				sprite.play("run")
		else:
			if sprite.animation != "idle":
				sprite.play("idle")

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed(
	"SaveGame"
):
		SaveManager.save_game()
	if Input.is_action_just_pressed(
		"LoadGame"
	):
		SaveManager.load_game()

func attack():
	if is_attacking:
		return

	hit_enemies.clear()
	is_attacking = true
	sprite.play("attack")
	AudioManager.play_sound(AudioManager.player_sword_sound)
	attack_area.position.x = 25 * facing_direction
	attack_area.monitoring = true
	attack_timer.start()

func add_coin():
	GameManager.add_coin()
	coins = GameManager.total_coins

func set_checkpoint(new_position):
	respawn_position = new_position + Vector2(0, -40)
	print("Nuevo respawn:", respawn_position)

func _on_death_zone_body_entered(body):
	if body.name == "Player":
		body.die()

func _on_damage_timer_timeout():
	can_take_damage = true

func _on_attack_timer_timeout():
	attack_area.monitoring = false
	is_attacking = false

func _on_attack_area_body_entered(body):
	if body == self:
		return
	if hit_enemies.has(body):
		return
	if body.has_method("take_damage"):
		hit_enemies.append(body)
		body.take_damage(
			1,
			global_position
		)

func is_player():
	return true

func heal(amount):
	GameManager.player_health += amount
	GameManager.player_health = min(

		GameManager.player_health,
		GameManager.player_max_health)

	GameManager.health_changed.emit(
		GameManager.player_health)

