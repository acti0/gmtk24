extends Node3D


# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		$Board/Tile.move(Vector3.LEFT)
	if event.is_action_pressed("debug2"):
		$Board/Tile.move(Vector3.RIGHT)

