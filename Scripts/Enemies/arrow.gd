extends Area2D

@export var speed := 300.0

var direction := 1


func _physics_process(delta):
	scale.x = sign(direction)
	position.x += direction * speed * delta

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	body.take_damage(
		1,
		global_position
	)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

