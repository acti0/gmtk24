extends Control

var raycast: RayCast3D
@onready var crosshair: TextureRect = $Crosshair

func _ready() -> void:
	raycast = get_tree().get_nodes_in_group("interactable_detector")[0]

func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		if raycast.get_collider() is ShrinkableObject or raycast.get_collider() is RigidBody3D:
			crosshair.texture = load("res://assets/img/crosshair_green.png")
	else:
		crosshair.texture = load("res://assets/img/crosshair_black.png")
