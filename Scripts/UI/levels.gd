extends Control

func _ready():
	pass

func _on_level_card_1_pressed():
	GameManager.current_level = "res://Scenes/Levels/Level01.tscn"
	SceneManager.load_current_level()

func _on_level_card_2_pressed():
	GameManager.current_level = "res://Scenes/Levels/Level02.tscn"
	SceneManager.load_current_level()

func _on_level_card_3_pressed():
	GameManager.current_level = "res://Scenes/Levels/Level03.tscn"
	SceneManager.load_current_level()

func _on_level_card_4_pressed():
	GameManager.current_level = "res://Scenes/Levels/Level04.tscn"
	SceneManager.load_current_level()

func _on_level_card_5_pressed():
	GameManager.current_level = "res://Scenes/Levels/Level05.tscn"
	SceneManager.load_current_level()

func _on_back_button_pressed():
	get_tree().change_scene_to_file(
		"res://Scenes/UI/MainMenu.tscn"
	)



