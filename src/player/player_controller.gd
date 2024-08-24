extends Node3D

'''
Handles all actions the player can do
'''

@export var player: CharacterBody3D
@export var speed: float = 5.0
@export var jump_velocity: float = 5
@export_range (0, 90) var camera_upper_bounds: float = 90
@export_range (-90, 0) var camera_lower_bounds: float = -90

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var object: RigidBody3D = null
var prev_object_marker_posiion: Vector3 = Vector3.ZERO

@onready var camera: Camera3D = %Camera3D
@onready var neck: Node3D = %Neck
@onready var interactable_ray: RayCast3D = %InteractableDetector
@onready var object_marker: Marker3D = %ObjectMarker
@onready var state_chart: StateChart = %StateChart

## Connect signals
func _ready() -> void:
	Preferences.cheats_changed.connect(_on_cheats_changed)

## Toggle superjump
func _on_cheats_changed() -> void:
	if Preferences.cheats_active: 
		jump_velocity = 20
	else:
		jump_velocity = 5

## Handle all possible inputs
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		state_chart.send_event("jump_pressed")
	
	# Interaction logic
	if Input.is_action_just_pressed("interact"):
		if object:
			object.interact()
			object = null
		elif interactable_ray.is_colliding():
			var collider = interactable_ray.get_collider()
			if collider is ShrinkableObject:
				collider.interact()
			elif collider is BaseObject:
				object = collider
				collider.interact()
	
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
	
	# Move camera based on mouse movement
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * 0.01 * Preferences.mouse_sensitivity)
		camera.rotate_x(-event.relative.y * 0.01 * Preferences.mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(camera_lower_bounds), deg_to_rad(camera_upper_bounds))

## Move held object relative to player cam
func _physics_process(delta: float) -> void:
	if object:
		if object_marker.global_position != prev_object_marker_posiion:
			object.global_position = object_marker.global_position
		prev_object_marker_posiion = object_marker.global_position

## Process movement input
func _process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * speed * player.scale.x
		player.velocity.z = direction.z * speed * player.scale.z
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.z = move_toward(player.velocity.z, 0, speed)
	
	if player.is_on_floor():
		state_chart.send_event("ground_touched")
	else:
		state_chart.send_event("in_air")
	
	player.move_and_slide()

## Apply jump velocity
func _on_jump_state_entered() -> void:
	player.velocity.y = jump_velocity

## Apply gravity
func _on_fall_state_processing(delta: float) -> void:
	player.velocity.y -= gravity * delta
