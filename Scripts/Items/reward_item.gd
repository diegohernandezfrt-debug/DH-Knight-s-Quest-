extends Area2D

enum RewardType{
	COINS_20,
	COINS_80,
	COINS_100,
	HEART
}

@export var reward_type = RewardType.COINS_20

var velocity = Vector2.ZERO
var reward_gravity := 800.0

var landed := false

@onready var sprite = $AnimatedSprite2D


func _ready():
	velocity.x = randf_range(-40,40)
	velocity.y = -220


func _physics_process(delta):
	if landed:
		return

	velocity.y += reward_gravity * delta
	position += velocity * delta

	if velocity.y > 0:
		landed = true
		velocity = Vector2.ZERO

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	match reward_type:

		RewardType.COINS_20:
			GameManager.total_coins += 20
			AudioManager.play_sound(AudioManager.coin_sound)

		RewardType.COINS_80:
			GameManager.total_coins += 80
			AudioManager.play_sound(AudioManager.coin_sound)

		RewardType.COINS_100:
			GameManager.total_coins += 100
			AudioManager.play_sound(AudioManager.coin_sound)

		RewardType.HEART:
			GameManager.player_health += 1
			AudioManager.play_sound(AudioManager.bonus_heart)
			GameManager.player_health = min(

				GameManager.player_health,
				GameManager.player_max_health
			)

			GameManager.health_changed.emit(
				GameManager.player_health
			)

	GameManager.coins_changed.emit(
		GameManager.total_coins
	)

	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func setup(type):

	reward_type = type

	match reward_type:

		RewardType.COINS_20:
			sprite.play("coins20")

		RewardType.COINS_80:
			sprite.play("coins80")

		RewardType.COINS_100:
			sprite.play("coins100")

		RewardType.HEART:
			sprite.play("heart")
