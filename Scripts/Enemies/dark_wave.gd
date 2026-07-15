extends Area2D

@export var speed := 220

var direction := 1

@onready var sprite = $AnimatedSprite2D

func set_direction(dir):
	direction = dir
	sprite.flip_h = direction < 0

func _physics_process(delta):
	position.x += direction * speed * delta

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	body.take_damage(1, global_position)
	queue_free()
