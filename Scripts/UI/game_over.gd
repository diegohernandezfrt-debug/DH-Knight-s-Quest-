extends CanvasLayer

@onready var sprite = $AnimatedSprite2D

func _ready():
	visible = false

	GameManager.game_over.connect(
		show_game_over
	)

func show_game_over():
	visible = true
	AudioManager.play_game_over_music()
	get_tree().paused = true
	sprite.play("game_over")

func _on_retry_menu_button_pressed():
	get_tree().paused = false
	SaveManager.load_game()

	if GameManager.player_health <= 0:
		GameManager.player_health = GameManager.player_max_health

	GameManager.health_changed.emit(GameManager.player_health)

	get_tree().change_scene_to_file(
		GameManager.current_level
	)

func _on_menu_button_3_pressed():
	get_tree().paused = false

	AudioManager.stop_music()
	GameManager.reset_game()

	get_tree().change_scene_to_file(
		"res://Scenes/UI/MainMenu.tscn"
	)

