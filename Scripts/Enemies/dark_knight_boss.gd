extends EnemyBase

class_name DarkKnightBoss

@onready var sprite = $AnimatedSprite2D

@export var wave_scene : PackedScene
@export var speed := 70
@export var attack_distance := 100

var player = null
var active = false
var attacking = false
var last_attack := -1
var cooldown := false
var attack_direction := 1
var facing_direction := 1

func _ready():
	super._ready()
	receives_knockback = false
	sprite.play("idle")

func _on_detection_area_body_entered(body):
	if not body.is_in_group("player"):
		return

	player = body
	active = true

func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		active = false
		attacking = false
		velocity.x = 0
		sprite.play("idle")

func _physics_process(delta):
	if player == null:
		var bodies = $DetectionArea.get_overlapping_bodies()
		for body in bodies:

			if body.is_in_group("player"):
				player = body
				break
	
	if is_dead:
		return

	if stunned:
		apply_gravity(delta)
	
		move_and_slide()
		return

	apply_gravity(delta)

	if player == null:
		velocity.x = 0

		if sprite.animation != "idle":
			sprite.play("idle")

		move_and_slide()
		return

	if attacking:

		move_and_slide()
		return

	var dist = abs(
		player.global_position.x - global_position.x)

	if dist > attack_distance:
		chase()
	else:
		start_attack()

	move_and_slide()

func chase():
	if sprite.animation != "run":
		sprite.play("run")

	var dir = sign(
		player.global_position.x - global_position.x)

	velocity.x = dir * speed

	sprite.flip_h = dir < 0

	update_attack_position()


func update_attack_position():
	if sprite.flip_h:
		$AttackArea.position.x = -30
	else:
		$AttackArea.position.x = 30

func attack_slash():
	attacking = true
	velocity.x = 0

	sprite.play("attack_slash")
	AudioManager.play_sound(AudioManager.boss_sword_sound)
	$AnimationPlayer.play("attack_events")


func attack_wave():
	attacking = true
	velocity.x = 0

	attack_direction = -1 if sprite.flip_h else 1

	sprite.play("attack_wave")

	await get_tree().create_timer(0.45).timeout

	if is_dead:
		return

	spawn_wave()

func enable_hitbox():
	$AttackArea.monitoring = true

func disable_hitbox():
	$AttackArea.monitoring = false

func _on_attack_area_body_entered(body):
	if not body.is_in_group("player"):
		return

	body.take_damage(1, global_position)

func spawn_wave():
	AudioManager.play_sound(AudioManager.dark_wave_sound)
	var wave = wave_scene.instantiate()

	get_parent().add_child(wave)

	var offset := 45

	if attack_direction == -1:
		offset = -45

	wave.global_position = global_position + Vector2(offset, -8)

	wave.set_direction(attack_direction)

func start_attack():
	if attacking:
		return

	if cooldown:
		return

	cooldown = true

	var value = randi() % 2

	if value == last_attack:
		value = 1 - value

	last_attack = value

	if value == 0:
		attack_slash()
	else:
		attack_wave()

	await get_tree().create_timer(1.0).timeout
	cooldown = false

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "attack_slash":
		disable_hitbox()
		attacking = false
		sprite.play("idle")

	elif sprite.animation == "attack_wave":
		attacking = false
		sprite.play("idle")

func die():
	super.die()
	attacking = false
	cooldown = false
	player = null

	sprite.play("dead")
	AudioManager.play_sound(AudioManager.dark_knight_death)
	set_physics_process(false)

	$CollisionShape2D.disabled = true
	$DetectionArea.monitoring = false

	await sprite.animation_finished
	GameManager.complete_level()

	queue_free()



