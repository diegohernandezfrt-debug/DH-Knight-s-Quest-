extends Node

signal coins_changed(new_amount)
signal health_changed(new_amount)
signal level_completed
signal game_over

enum GameState {
	PLAYING,
	PAUSED,
	LEVEL_COMPLETE,
	GAME_OVER
}

var highest_level_unlocked := 1

var checkpoint_position := Vector2.ZERO
var checkpoint_level := ""
var level_spawn_position = Vector2.ZERO

var total_coins := 0
var current_state = GameState.PLAYING
var current_level = "res://Scenes/Levels/Level01.tscn"
var level = 1

var player_max_health := 3
var player_health := 3

var enemies_killed := 0
var level_deaths := 0
var total_deaths := 0

var can_pause := true

func add_coin():
	total_coins += 1
	coins_changed.emit(total_coins)
	print("Monedas globales: ", total_coins)

func update_health(value):
	health_changed.emit(value)

func complete_level():
	print("Nivel completado")

func set_state(new_state):
	current_state = new_state
	print("Estado:", current_state)

func is_playing():
	return current_state == GameState.PLAYING

func reset_player_health():
	player_health = player_max_health
	health_changed.emit(player_health)

func damage_player(amount):
	player_health -= amount
	print("Vida GameManager:", player_health)

	if player_health <= 0:
		player_health = 0
		game_over.emit()

	health_changed.emit(player_health)

func reset_game():
	total_coins = 0
	player_health = player_max_health
	enemies_killed = 0
	level_deaths = 0
	total_deaths = 0
	checkpoint_position = Vector2.ZERO
	current_level = "res://Scenes/Levels/Level01.tscn"
	coins_changed.emit(total_coins)
	health_changed.emit(player_health)

func add_enemy_kill():
	enemies_killed += 1

func register_death():
	level_deaths += 1
	total_deaths += 1

