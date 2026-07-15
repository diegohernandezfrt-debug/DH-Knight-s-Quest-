extends CanvasLayer

@onready var coins_label = $CoinsLabel
@onready var enemies_label = $EnemiesLabel
@onready var level_deaths_label = $LevelDeathsLabel
@onready var total_deaths_label = $TotalDeathsLabel

func _ready():
	visible = false

	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func show_victory():
	SaveManager.save_game()

	coins_label.text = "Coins: " + str(GameManager.total_coins)
	enemies_label.text = "Enemis: " + str(GameManager.enemies_killed)
	level_deaths_label.text = "Levels Dead: " + str(GameManager.level_deaths)
	total_deaths_label.text = "All Dead: " + str(GameManager.total_deaths)

	visible = true
	AudioManager.play_victory_music()
	get_tree().paused = true

func _on_continue_button_2_pressed():
	SaveManager.save_game()
	get_tree().paused = false
	SceneManager.load_next_level()

func _on_menu_button_2_pressed():
	SaveManager.save_game()
	get_tree().paused = false

	AudioManager.stop_music()
	GameManager.reset_game()

	get_tree().change_scene_to_file(
		"res://Scenes/UI/MainMenu.tscn"
	)



