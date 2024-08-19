extends Area3D

var finished: bool = false

func _on_body_entered(body: Node3D) -> void:
	if !finished:
		finished = true
		EventBus.game_finished.emit()
