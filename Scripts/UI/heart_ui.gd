extends Control

@export var full_heart : Texture2D
@export var empty_heart : Texture2D

@onready var hearts = [
	$HBoxContainer/Heart1,
	$HBoxContainer/Heart2,
	$HBoxContainer/Heart3
]

func _ready():
	GameManager.health_changed.connect(update_hearts)
	update_hearts(GameManager.player_health)

func update_hearts(current_health):
	for i in range(hearts.size()):

		if i < current_health:
			hearts[i].texture = full_heart
		else:
			hearts[i].texture = empty_heart





