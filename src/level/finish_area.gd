extends Area3D

var finished: bool = false
var cheats: Cheats = preload("res://src/resource/cheats.tres")

## Emit game finished
func _on_body_entered(_body: Node3D) -> void:
	if !finished:
		finished = true
		cheats.cheats_visible = true
		EventBus.game_finished.emit()
