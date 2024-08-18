extends Control

@onready var pause_menu: Menu = %PauseMenu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_pause"):
		if get_tree().paused:
			pause_menu.close()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
			pause_menu.open()

	if event is InputEventMouseButton and !get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_pause_menu_closed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
