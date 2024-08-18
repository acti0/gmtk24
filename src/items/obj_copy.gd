class_name CopyObject extends StaticBody3D

@export var obj_name: String

## Connect to signal
func _ready() -> void:
	EventBus.base_object_transform_changed.connect(_on_base_object_transform_changed)

## Copy the transform from the base object
func _on_base_object_transform_changed(base_obj_name: String, obj_transform: Transform3D) -> void:
	if obj_name == base_obj_name:
		transform = obj_transform
