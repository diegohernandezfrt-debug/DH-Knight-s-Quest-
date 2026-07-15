extends Node

const SAVE_FILE = "user://savegame.json"

func save_game():
	var save_data = {
		"coins": GameManager.total_coins,
		"health": GameManager.player_health,
		"level": GameManager.current_level,
		"checkpoint_x": GameManager.checkpoint_position.x,
		"checkpoint_y": GameManager.checkpoint_position.y,
		"checkpoint_level": GameManager.checkpoint_level,
		"enemies_killed": GameManager.enemies_killed,
		"level_deaths": GameManager.level_deaths,
		"total_deaths": GameManager.total_deaths
	}

	var file = FileAccess.open(
		SAVE_FILE,
		FileAccess.WRITE
	)
	file.store_string(
		JSON.stringify(save_data)
	)
	print("Partida guardada")

func load_game():
	if not FileAccess.file_exists(
		SAVE_FILE
	):
		print("No existe guardado")
		return

	var file = FileAccess.open(
		SAVE_FILE,
		FileAccess.READ
	)

	var json_text = file.get_as_text()
	var json = JSON.new()
	var result = json.parse(json_text)

	if result != OK:
		print("Error al leer save")
		return

	var data = json.data

	GameManager.total_coins = data["coins"]
	GameManager.player_health = data["health"]
	GameManager.current_level = data["level"]

	GameManager.enemies_killed = data.get(
	"enemies_killed",
	0
)

	GameManager.level_deaths = data.get(
	"level_deaths",
	0
)

	GameManager.total_deaths = data.get(
	"total_deaths",
	0
)

	print("Partida cargada")

	GameManager.checkpoint_position = Vector2(
	data["checkpoint_x"],
	data["checkpoint_y"]
	)

	GameManager.checkpoint_level = data.get(
	"checkpoint_level",
	""
	)

func continue_game():
	load_game()

	SceneManager.change_scene(
		GameManager.current_level
	)

