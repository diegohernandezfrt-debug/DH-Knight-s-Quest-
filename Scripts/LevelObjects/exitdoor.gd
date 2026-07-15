extends Area2D

var completed := false

func _on_body_entered(body):
	if body.name == "Player":
		var victory = get_tree().get_first_node_in_group(
			"victory_screen"
		)

		if victory:

			victory.show_victory()
