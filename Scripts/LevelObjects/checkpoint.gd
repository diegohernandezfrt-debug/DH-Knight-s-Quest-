extends Area2D

@onready var sprite = $AnimatedSprite2D

var activated := false

func _on_body_entered(body):
	if body.has_method("set_checkpoint"):
		body.set_checkpoint(global_position)
		GameManager.checkpoint_position = global_position

		GameManager.checkpoint_level = \
		GameManager.current_level

		SaveManager.save_game()
		AudioManager.play_sound(AudioManager.checkpoint_sound)
		print("Checkpoint activado")

	sprite.play("checkpoint")
