extends Menu

signal switch_menu

@onready var key_bind_display: GridContainer = %KeyBindings
@onready var options = %Options
@onready var cheats_menu = %Cheats

## Set up keybinding display
func _ready() -> void:
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

## Resume game
func _on_resume_button_pressed() -> void:
	close()

func _on_main_menu_button_pressed() -> void:
	hide()
	switch_menu.emit()
