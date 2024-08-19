class_name BaseObject extends RigidBody3D

@export var obj_name: String
var prev_position: Vector3 = Vector3.ZERO

## Emit signal on transform change
func _physics_process(delta: float) -> void:
	if global_position != prev_position:
		EventBus.base_object_transform_changed.emit(obj_name, transform)
	prev_position = global_position

func grow() -> void:
	pass
	#scale = Vector3(1, 1, 1)

## Base object can be picked up and dropped
func interact() -> void:
	# Dropping the object
	if freeze:
		print("Drop " +name)
		freeze = false
	# Picking up the object
	else:
		print("Pick up " +name)
		freeze = true
		rotation = Vector3.ZERO
