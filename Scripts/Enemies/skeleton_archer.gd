extends EnemyBase

@export var arrow_scene : PackedScene
@onready var sprite = $AnimatedSprite2D

var player_detected := false
var player : Node2D

func _ready():
	super._ready()
	$AnimatedSprite2D.play("idle")
	print("Skeleton listo")

func _physics_process(delta):
	if is_dead:
		return

	if stunned:
		apply_gravity(delta)
		move_and_slide()
		return

	apply_gravity(delta)

	if player != null:
		if player.global_position.x < global_position.x:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

	move_and_slide()

func _on_detection_area_body_entered(body):
	print("Entró:", body.name)
	if body.name == "Player":
		print("Jugador detectado")
		player_detected = true
		player = body

func _on_detection_area_body_exited(body):
	print("Salió:", body.name)
	if body.name == "Player":
		player_detected = false
		player = null

func _on_shoot_timer_timeout():
	print("Timer ejecutado")
	if not player_detected:
		return

	AudioManager.play_sound(AudioManager.bow_sound)
	shoot()

func shoot():
	if is_dead:
		return
	if stunned:
		return

	$AnimatedSprite2D.play("attack")
	AudioManager.play_sound(AudioManager.arrow_sound)
	var arrow = arrow_scene.instantiate()
	get_parent().add_child(arrow)

	if player.global_position.x < global_position.x:
		arrow.direction = -1
		arrow.global_position = $MarkerLeft.global_position
	else:
		arrow.direction = 1
		arrow.global_position = $MarkerRight.global_position

func _on_animated_sprite_2d_animation_finished():
	if is_dead:
		queue_free()
		return

	if $AnimatedSprite2D.animation == "attack":
		$AnimatedSprite2D.play("idle")

func die():
	super.die()
	sprite.play("dead")
	AudioManager.play_sound(AudioManager.skeleton_death_sound)
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	await sprite.animation_finished
	queue_free()

	print("Skeleton eliminado")



