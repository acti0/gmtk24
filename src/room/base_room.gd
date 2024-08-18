extends Node3D

## Connect signals
func _ready() -> void:
	EventBus.new_object_shrunk.connect(_on_new_object_shrunk)

## Move the RigidBody3D into position and unfreeze
func _on_new_object_shrunk(obj_name: String, obj_position: Vector3) -> void:
	$Cube_Base.global_position = obj_position
	$Cube_Base.freeze = false
