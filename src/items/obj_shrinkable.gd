class_name ShrinkableObject extends Node3D

@export var obj_name: String
@export var shrink_speed: float = 1
var shrinking: bool = false

## The object will shrink and delete itself
## It emits a signal so a copy can be made before death
func _physics_process(delta: float) -> void:
	if shrinking:
		scale -= scale * shrink_speed * delta
		if scale.x < (1.0/24.0):
			scale = Vector3(1.0/24.0, 1.0/24.0, 1.0/24.0)
			shrinking = false
			EventBus.new_object_shrunk.emit(obj_name, global_position, rotation)
			queue_free()

## Start rescaling the object
func interact() -> void:
	shrinking = true
