extends DamageSource

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	body.take_damage(
		damage,
		global_position
	)
