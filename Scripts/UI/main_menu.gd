extends Control

@onready var animation = $AnimationPlayer

func _ready():
	AudioManager.play_menu_music()
	animation.play("logo")

func _on_continue_button_pressed():
	SaveManager.continue_game()

func _on_new_game_button_pressed():
	GameManager.total_coins = 0
	GameManager.current_level = 1
	GameManager.reset_player_health()

	SceneManager.change_scene(
		"res://Scenes/Levels/Level01.tscn"
	)

func _on_levels_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Levels.tscn")


func _on_exit_button_pressed():
	get_tree().quit()


