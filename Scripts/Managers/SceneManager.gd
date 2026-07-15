extends Node

func change_scene(scene_path:String):
	GameManager.set_state(
		GameManager.GameState.PLAYING
	)

	get_tree().paused = false
	get_tree().change_scene_to_file(
		scene_path
	)
	AudioManager.start_game_music()

func load_current_level():
	change_scene(
		GameManager.current_level
	)

func load_next_level():
	match GameManager.current_level:

		"res://Scenes/Levels/Level01.tscn":
			GameManager.current_level = "res://Scenes/Levels/Level02.tscn"

		"res://Scenes/Levels/Level02.tscn":
			GameManager.current_level = "res://Scenes/Levels/Level03.tscn"

		"res://Scenes/Levels/Level03.tscn":
			GameManager.current_level = "res://Scenes/Levels/Level04.tscn"

		"res://Scenes/Levels/Level04.tscn":
			GameManager.current_level ="res://Scenes/Levels/Level05.tscn"

		"res://Scenes/Levels/Level05.tscn":
			get_tree().change_scene_to_file(
				"res://Scenes/UI/MainMenu.tscn"
			)
			return

	GameManager.checkpoint_position = Vector2.ZERO
	GameManager.checkpoint_level = ""
	SaveManager.save_game()

	change_scene(
		GameManager.current_level
	)

