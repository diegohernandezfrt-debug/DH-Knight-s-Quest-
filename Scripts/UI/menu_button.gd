extends Area2D

signal pressed

var hovering := false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and hovering:
				pressed.emit()

func _on_mouse_entered():
	hovering = true
	scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	hovering = false
	scale = Vector2.ONE


