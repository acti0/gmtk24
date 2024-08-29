extends CharacterBody3D

'''
Alternate version of the player scene w/o State Charts
'''

@export var speed: float = 5.0
@export var jump_velocity: float = 5.0
@export_range (0, 90) var camera_upper_bounds: float = 90
@export_range (-90, 0) var camera_lower_bounds: float = -90
var grow_speed: float = 1
var growing: bool = false

@onready var camera = %Camera3D

## Connect signals
func _ready() -> void:
	Preferences.cheats_changed.connect(_on_cheats_changed)

## Toggle superjump
func _on_cheats_changed() -> void:
	if Preferences.cheats_active: 
		jump_velocity = 20
	else:
		jump_velocity = 5

## Camera movement
func _unhandled_input(event: InputEvent) -> void:
	# Move camera based on mouse movement
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.01 * Preferences.mouse_sensitivity)
		camera.rotate_x(-event.relative.y * 0.01 * Preferences.mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(camera_lower_bounds), deg_to_rad(camera_upper_bounds))

## WASD Movement + jump
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed * scale.x
		velocity.z = direction.z * speed * scale.z
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	# Grow player back
	if growing:
		scale += scale * grow_speed * delta
		if scale.y > 1.0:
			scale = Vector3(1, 1, 1)
			growing = false

	move_and_slide()

## Start growing player to scale = 1
func grow() -> void:
	growing = true
