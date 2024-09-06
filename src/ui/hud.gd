extends Control

'''
Parent of all HUD elements
'''

var raycast: RayCast3D
@onready var crosshair: TextureRect = $Crosshair
@onready var finish_container: PanelContainer = $PanelContainer

@export var default_crosshair: Texture2D
@export var interactable_crosshair: Texture2D

## Connect to external stuff
func _ready() -> void:
	raycast = get_tree().get_nodes_in_group("interactable_detector")[0]
	EventBus.game_finished.connect(_on_game_finished)

## Change crosshair if object is in range
func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		if raycast.get_collider() is ShrinkableObject or raycast.get_collider() is BaseObject:
			crosshair.texture = interactable_crosshair
			$InteractHint.show()
	else:
		crosshair.texture = default_crosshair
		$InteractHint.hide()

## Show the game finish message
func _on_game_finished() -> void:
	finish_container.show()
	await get_tree().create_timer(10.0).timeout
	finish_container.hide()
