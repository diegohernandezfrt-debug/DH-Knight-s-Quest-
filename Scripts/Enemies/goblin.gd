extends EnemyBase

@export var speed := 50.0

var direction := 1

@onready var raycast = $RayCast2D
@onready var sprite = $AnimatedSprite2D

func _ready():
	super._ready()
	sprite.play("run")

func _physics_process(delta):
	if is_dead:
		return

	if stunned:
		apply_gravity(delta)
		velocity.x = move_toward(
			velocity.x,
			0,
			600 * delta
		)
		move_and_slide()
		return

		if sprite.animation != "hit":
			sprite.play("run")

		move_and_slide()
		return

	apply_gravity(delta)

	if not raycast.is_colliding():
		turn_around()

	velocity.x = speed * direction
	move_and_slide()

func turn_around():
	direction *= -1
	scale.x *= -1
	raycast.position.x *= -1

func _on_hurt_area_body_entered(body):
	print(body.name)
	print(body.get_script())

	if not body.is_in_group("player"):
		return

	body.take_damage(1, global_position)

func die():
	super.die()
	sprite.play("dead")
	AudioManager.play_sound(AudioManager.goblin_death_sound)
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	await sprite.animation_finished

	queue_free()
