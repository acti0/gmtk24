extends Menu

@onready var key_bind_display: GridContainer = %KeyBindings
@onready var cheats_container = %CheatsContainer
@onready var mouse_sense_slider = %MouseSenseSlider

func _ready() -> void:
	EventBus.game_finished.connect(_on_game_finished)

func _on_game_finished() -> void:
	cheats_container.show()

func open() -> void:
	# Only use display actions without "ui"-prefix
	var all_actions: Array[StringName] = InputMap.get_actions()
	all_actions = all_actions.filter(func(action): return !action.begins_with("ui"))
	
	# Show first event for each action
	for action in all_actions:
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		
		var key_name: Label = Label.new()
		key_name.text = action
		key_bind_display.add_child(key_name)
		
		var key_bind: Label = Label.new()
		var text = events[0].as_text()
		key_bind.text = text.substr(0, text.find("("))
		key_bind_display.add_child(key_bind)
	
	super.open()

func close() -> void:
	for child in key_bind_display.get_children():
		child.queue_free()
	super.close()

func _on_resume_button_pressed() -> void:
	close()

func _on_reset_objects_pressed() -> void:
	EventBus.reset_objects.emit()

func _on_big_world_check_button_pressed() -> void:
	EventBus.big_world_toggled.emit()

func _on_cheats_check_button_pressed() -> void:
	EventBus.cheats_toggled.emit()

func _on_mouse_sense_slider_drag_ended(value_changed: bool) -> void:
	EventBus.mouse_sense_changed.emit(mouse_sense_slider.value)
