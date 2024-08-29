extends Node3D

'''
Handles player interaction w/ objects
'''

var object: RigidBody3D = null
var prev_object_marker_posiion: Vector3 = Vector3.ZERO

@onready var interactable_ray: RayCast3D = %InteractableDetector
@onready var object_marker: Marker3D = %ObjectMarker

## Move held object relative to player cam
func _physics_process(delta: float) -> void:
	if object:
		if object_marker.global_position != prev_object_marker_posiion:
			object.global_position = object_marker.global_position
		prev_object_marker_posiion = object_marker.global_position
		
		## Prevent object from ever not being aligned
		if (int(object.rotation_degrees.x) % 30 != 0 
		or int(object.rotation_degrees.y) % 30 != 0 
		or int(object.rotation_degrees.z) % 30 != 0):
			object.angular_velocity = Vector3.ZERO
			object.linear_velocity = Vector3.ZERO
			object.rotation = Vector3.ZERO


func _unhandled_input(event: InputEvent) -> void:
	# Interaction logic
	if Input.is_action_just_pressed("interact"):
		if object:
			if interactable_ray.get_collider() == object:
				object.interact()
				object = null
		elif interactable_ray.is_colliding():
			var collider = interactable_ray.get_collider()
			if collider is ShrinkableObject:
				collider.interact()
			elif collider is BaseObject:
				object = collider
				object.interact()

	# Adjust held object (rotation)
	if object:
		if Input.is_action_just_pressed("rotate_left"):
			object.rotation_degrees.y -= 30
		if Input.is_action_just_pressed("rotate_right"):
			object.rotation_degrees.y += 30
		if Input.is_action_just_pressed("rotate_up"):
			object.rotation_degrees.z += 30
		if Input.is_action_just_pressed("rotate_down"):
			object.rotation_degrees.z -= 30
