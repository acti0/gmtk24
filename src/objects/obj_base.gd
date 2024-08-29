class_name BaseObject extends RigidBody3D

@export var obj_name: String
var prev_position: Vector3 = Vector3.ZERO

## Emit signal on transform change
func _physics_process(delta: float) -> void:
	if global_position != prev_position:
		EventBus.base_object_transform_changed.emit(obj_name, transform)
	prev_position = global_position
	
	'''
	if get_colliding_bodies().size() > 0:
		var xy: ArrayMesh = $Cheese.mesh as ArrayMesh
		$Cheese.mesh.surface_0.albedo_color = 0xff00ff
	else:
		$Cheese.mesh.surface_0.albedo_color = 0xffffff
	'''

## Grow object back to normal size if it falls off stage
func grow() -> void:
	scale = Vector3(1, 1, 1)

## Base object can be picked up and dropped
func interact() -> void:
	# Dropping the object
	if freeze:
		print("Drop " +name)
		set_collision_layer_value(3, true)
		freeze = false
	# Picking up the object
	else:
		print("Pick up " +name)
		set_collision_layer_value(3, false)
		freeze = true
		angular_velocity = Vector3.ZERO
		linear_velocity = Vector3.ZERO
		rotation = Vector3.ZERO
