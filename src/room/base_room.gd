extends Node3D

## Connect signals
func _ready() -> void:
	EventBus.new_object_shrunk.connect(_on_new_object_shrunk)

## Move the RigidBody3D into position and unfreeze
func _on_new_object_shrunk(obj_name: String, obj_position: Vector3, obj_rotation: Vector3) -> void:
	for child in get_children():
		if child is BaseObject and child.obj_name == obj_name:
			child.global_position = obj_position
			child.rotation = obj_rotation
			child.freeze = false
