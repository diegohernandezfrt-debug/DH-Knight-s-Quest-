extends Area2D

enum RewardType{
	COINS_20,
	COINS_80,
	COINS_100,
	HEART
}

@export var reward_type = RewardType.COINS_20
@export var reward_scene : PackedScene

var opened = false

@onready var sprite = $AnimatedSprite2D


func _on_body_entered(body):
	if opened:
		return

	if not body.is_in_group("player"):
		return

	opened = true

	sprite.play("openchest")
	AudioManager.play_sound(
	AudioManager.chest_sound_open)
	await sprite.animation_finished
	spawn_reward()

func spawn_reward():
	var reward = reward_scene.instantiate()
	get_parent().add_child(reward)

	reward.global_position = global_position + Vector2(0, -16)
	reward.setup(reward_type)


