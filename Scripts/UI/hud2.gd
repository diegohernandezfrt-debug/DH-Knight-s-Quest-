extends CanvasLayer

@onready var health_label = $Control/HealthLabel
@onready var coin_label = $Control/CoinLabel
@onready var message_label = $Control/MessageLabel

func _ready():
	message_label.visible = false
	GameManager.coins_changed.connect(update_coins)
	GameManager.health_changed.connect(update_health)
	update_coins(GameManager.total_coins)
	update_health(
	GameManager.player_health
	)

func update_health(current_health):
	health_label.text = "Vida: " + str(current_health)

func update_coins(amount):
	coin_label.text = str(amount)

func show_message(text_message):
	message_label.text = text_message
	message_label.visible = true

func load_game():
	GameManager.coins_changed.emit(
	GameManager.total_coins
	)
	GameManager.health_changed.emit(
		GameManager.player_health
	)
