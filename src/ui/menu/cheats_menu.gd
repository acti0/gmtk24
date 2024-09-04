extends Menu

@export var cheats: Cheats

var secret_code: Array[String] = ["Up", "Up", "Down", "Down", "Left", "Right", "Left", "Right"]
var secret_code_index: int = 0

func _ready() -> void:
	cheats.changed.connect(_on_cheats_changed)

func _on_cheats_changed() -> void:
	if cheats.cheats_visible:
		show()

func _on_cheats_check_button_pressed() -> void:
	cheats.high_jump = !cheats.high_jump


## Check for secret code inputs
func _input(_event: InputEvent) -> void:
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
				cheats.cheats_visible = true
				secret_code_index = 0
			else:
				secret_code_index += 1
		else:
			secret_code_index = 0
