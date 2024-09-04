extends Menu

signal switch_menu

@onready var key_bind_display: GridContainer = %KeyBindings
@onready var options = %Options
@onready var cheats_menu = %Cheats

var secret_code: Array[String] = ["Up", "Up", "Down", "Down", "Left", "Right", "Left", "Right"]
var secret_code_index: int = 0

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
	
	EventBus.game_finished.connect(_on_game_finished)

## Show cheats
func _on_game_finished() -> void:
	cheats_menu.show()

## Check for secret code inputs
func _input(event: InputEvent) -> void:
	var input_name: String
	if Input.is_action_just_pressed("rotate_up"):
		input_name = "Up"
	if Input.is_action_just_pressed("rotate_left"):
		input_name = "Left"
	if Input.is_action_just_pressed("rotate_down"):
		input_name = "Down"
	if Input.is_action_just_pressed("rotate_right"):
		input_name = "Right"
	
	if input_name:
		if input_name == secret_code[secret_code_index]:
			if secret_code_index == (secret_code.size() -1):
				cheats_menu.show()
				secret_code_index = 0
			else:
				secret_code_index += 1
		else:
			secret_code_index = 0

## Check if cheats are active
func open() -> void:
	super.open()

## Resume game
func _on_resume_button_pressed() -> void:
	close()

func _on_main_menu_button_pressed() -> void:
	hide()
	switch_menu.emit()
