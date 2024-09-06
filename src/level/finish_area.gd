extends Area3D

var finished: bool = false

## Emit game finished
func _on_body_entered(_body: Node3D) -> void:
	if !finished:
		finished = true
		EventBus.game_finished.emit()
