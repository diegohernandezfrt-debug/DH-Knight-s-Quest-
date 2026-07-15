extends Node2D

func _ready():
	GameManager.current_level = \
	"res://Scenes/Levels/Level05.tscn"

	GameManager.level_spawn_position = $SpawnPoint.global_position
