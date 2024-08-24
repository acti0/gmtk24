extends Control

'''
Responsible for switching in and out of pause mode
'''

@onready var main_menu: Menu = %MainMenu
@onready var pause_menu: Menu = %PauseMenu

var player_camera: Camera3D
var menu_camera: Camera3D

## Setup cameras
func _ready() -> void:
	player_camera = get_tree().get_nodes_in_group("player_camera")[0]
	menu_camera = get_tree().get_nodes_in_group("menu_camera")[0]

## Handle pause toggle and clicking in window
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause"):
		if get_tree().paused:
			pause_menu.close()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
			menu_camera.current = true
			pause_menu.open()

	if event is InputEventMouseButton and !get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

## Get back into the game
func _on_sub_menu_closed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	player_camera.current = true

## 
func _on_pause_menu_switch_menu() -> void:
	main_menu.open()
