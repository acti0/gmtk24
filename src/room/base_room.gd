extends Node3D

@onready var reset_marker: Marker3D = %ResetMarker3D

## Connect signals
func _ready() -> void:
	EventBus.new_object_shrunk.connect(_on_new_object_shrunk)
	EventBus.reset_objects.connect(_on_reset_objects)

## Move the RigidBody3D into position and unfreeze
func _on_new_object_shrunk(obj_name: String, obj_position: Vector3, obj_rotation: Vector3) -> void:
	for child in get_children():
		if child is BaseObject and child.obj_name == obj_name:
			child.global_position = obj_position
			child.rotation = obj_rotation
			child.freeze = false

## Reset all non-frozen objects position to reset marker
func _on_reset_objects() -> void:
	var offset: float = 0
	for child in get_children():
		if child is BaseObject and !child.freeze:
			child.position = reset_marker.position + Vector3(0, 0, offset)
			offset += .5
