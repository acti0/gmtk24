extends Node3D

@export var rotation_speed: float = 25

func _physics_process(delta: float) -> void:
	rotation_degrees.y += rotation_speed * delta
