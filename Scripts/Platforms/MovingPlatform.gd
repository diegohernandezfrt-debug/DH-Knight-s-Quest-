extends AnimatableBody2D

@export var point_a := Vector2.ZERO
@export var point_b := Vector2(200, 0)

@export var speed := 100.0

var target_position : Vector2

func _ready():
	global_position = point_a
	target_position = point_b

func _physics_process(delta):
	global_position = global_position.move_toward(
		target_position,
		speed * delta
	)

	if global_position.distance_to(
		target_position
	) < 5:

		if target_position == point_b:
			target_position = point_a
		else:
			target_position = point_b
