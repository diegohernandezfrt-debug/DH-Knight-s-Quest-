extends EnemyBase

@export var speed := 65.0

var player = null
var active := false

@onready var sprite = $AnimatedSprite2D

func _ready():
	super._ready()
	sprite.play("idle")

func _physics_process(delta):
	if is_dead:
		return

	if stunned:
		apply_gravity(delta)
		move_and_slide()
		return

	apply_gravity(delta)

	if active and player != null:
		sprite.play("run")

		var direction = sign(
			player.global_position.x
			-
			global_position.x
		)

		velocity.x = direction * speed
		sprite.flip_h = direction < 0
	else:
		velocity.x = 0

		if sprite.animation != "idle":
			sprite.play("idle")

	move_and_slide()

func _on_detection_area_body_entered(body):
	if not body.is_in_group("player"):
		return

	AudioManager.play_sound(AudioManager.mimic_chest)
	player = body
	active = true

func _on_detection_area_body_exited(body):
	if body == player:
		player = null
		active = false

func _on_hurt_area_body_entered(body):
	if not body.is_in_group("player"):
		return

	body.take_damage(
		1,
		global_position
	)

func die():
	super.die()
	sprite.play("dead")
	AudioManager.play_sound(AudioManager.mimic_chest)
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	$DetectionArea.monitoring = false
	await sprite.animation_finished

	queue_free()

