extends Node2D

func _ready():
	GameManager.current_level = \
	"res://Scenes/Levels/Level03.tscn"

	GameManager.level_spawn_position = $SpawnPoint.global_position
