extends DamageSource

@onready var sprite = $AnimatedSprite2D

func _ready():
	damage = 2
	sprite.play("fire")

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	body.take_damage(
		damage,
		global_position
	)

func is_enemy():
	return true

