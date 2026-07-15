extends Area2D

signal pressed

@export var level_number := 1
@onready var label = $Label
@onready var animation = $AnimationPlayer

func _ready():
	label.text = "Level " + str(level_number)

func _on_mouse_entered():
	scale = Vector2(1.05,1.05)

func _on_mouse_exited():
	scale = Vector2.ONE

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("Click")
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				pressed.emit()
