extends Node3D

@onready var copy_room_big: Node3D = $CopyRoomBig
@onready var copy_room_small: Node3D = $CopyRoomSmall

## Connect signal
func _ready() -> void:
	EventBus.big_world_toggled.connect(_on_big_world_toggled)

## Dis- or enable extra worlds
func _on_big_world_toggled() -> void:
	copy_room_big.visible = !copy_room_big.visible
	copy_room_small.visible = !copy_room_small.visible
