class_name CopyObject extends Node3D

@export var obj_name: String

## Connect to signal
func _ready() -> void:
	EventBus.base_object_transform_changed.connect(_on_base_object_transform_changed)

## Copy the transform from the base object
func _on_base_object_transform_changed(base_obj_name: String, obj_transform: Transform3D) -> void:
	if obj_name == base_obj_name:
		transform = obj_transform


'''EXPERIMENTAL: INFINITE OBJECT SHRINKING

@export var shrink_speed: float = 1
var shrinking: bool = false

## The object will shrink and delete itself
## It emits a signal so a copy can be made before death
func _physics_process(delta: float) -> void:
	if shrinking:
		scale -= scale * shrink_speed * delta
		if scale.x < (1.0/24.0):
			shrinking = false
			EventBus.new_object_shrunk.emit(obj_name, global_position, rotation)
			position = Vector3(0, 0, 0)
			scale = Vector3(1, 1, 1)

## Start rescaling the object
func interact() -> void:
	shrinking = true
'''
