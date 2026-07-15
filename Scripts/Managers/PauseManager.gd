extends Node

var pause_screen = null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

	await get_tree().process_frame

	pause_screen = get_tree().get_first_node_in_group("pause_screen")
	print("PauseScreen:", pause_screen)

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		toggle_pause()

func toggle_pause():

	get_tree().paused = !get_tree().paused

	var pause_screen = get_tree().get_first_node_in_group(
		"pause_screen"
	)

	if pause_screen:
		pause_screen.visible = get_tree().paused

	print("Pausa:", get_tree().paused)
