extends Node3D


func _physics_process(delta: float) -> void:
	rotation_degrees.y += 25 * delta
