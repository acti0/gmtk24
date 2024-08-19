extends Control

var raycast: RayCast3D
@onready var crosshair: TextureRect = $Crosshair

func _ready() -> void:
	raycast = get_tree().get_nodes_in_group("interactable_detector")[0]
	EventBus.game_finished.connect(_on_game_finished)

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		if raycast.get_collider() is ShrinkableObject or raycast.get_collider() is RigidBody3D:
			crosshair.texture = load("res://assets/img/crosshair_green.png")
	else:
		crosshair.texture = load("res://assets/img/crosshair_black.png")

func _on_game_finished() -> void:
	$PanelContainer.show()
	await get_tree().create_timer(10.0).timeout
	$PanelContainer.hide()
