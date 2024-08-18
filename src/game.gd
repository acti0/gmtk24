extends Node

## Toggle view
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_perspective"):
		var player_camera: Camera3D = get_tree().get_nodes_in_group("player_camera")[0]
		player_camera.current = !player_camera.current
