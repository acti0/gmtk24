extends Node3D

'''
Handles all movement the player can do
'''

@export var player: CharacterBody3D
@export var speed: float = 5.0
@export var jump_velocity: float = 5
@export_range (0, 90) var camera_upper_bounds: float = 90
@export_range (-90, 0) var camera_lower_bounds: float = -90

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = %Camera3D
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
	
	# Move camera based on mouse movement
	if event is InputEventMouseMotion:
		player.rotate_y(-event.relative.x * 0.01 * Preferences.mouse_sensitivity)
		camera.rotate_x(-event.relative.y * 0.01 * Preferences.mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(camera_lower_bounds), deg_to_rad(camera_upper_bounds))


## Process movement input
func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	if direction:
		player.velocity.x = direction.x * speed * player.scale.x
		player.velocity.z = direction.z * speed * player.scale.z
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.z = move_toward(player.velocity.z, 0, speed)
	
	player.move_and_slide()
	
	if player.is_on_floor():
		state_chart.send_event("ground_touched")
	else:
		state_chart.send_event("in_air")
	
	

## Apply jump velocity
func _on_jump_state_entered() -> void:
	player.velocity.y = jump_velocity

## Apply gravity
func _on_fall_state_processing(delta: float) -> void:
	player.velocity.y -= gravity * delta
