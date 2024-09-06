class_name PlayerStats extends Resource

@export var speed: float = 5.0
@export var sprint_speed: float = 7.5
@export var jump_velocity: float = 5.0
@export var mouse_sensitivity: float = 1.0

@export_category("Camera")
@export_range (0, 90) var camera_upper_bounds: float = 90
@export_range (-90, 0) var camera_lower_bounds: float = -90

@export_category("Extras")
## Whether player can grow/shrink themselves with arrow keys
@export var allow_self_growth: bool = false
@export var grow_speed: float = 1
var growing: bool = false
