extends Menu

@export var cheat_codes: Array[CheatCode]
var code_amount: int = 0

func _on_run_speed_check_button_pressed() -> void:
	Cheats.run_speed = !Cheats.run_speed

## Toggle high jump
func _on_high_jump_check_button_pressed() -> void:
	Cheats.high_jump = !Cheats.high_jump

func _on_fall_reset_check_button_pressed() -> void:
	Cheats.toggle_death_plane()

func _on_size_change_check_button_pressed() -> void:
	Cheats.toggle_size_change()

## Check for secret code inputs
func _input(_event: InputEvent) -> void:
	var input_name: CheatCode.CODE_ACTIONS
	if Input.is_action_just_pressed("rotate_up"):
		input_name = CheatCode.CODE_ACTIONS.Up
	if Input.is_action_just_pressed("rotate_left"):
		input_name = CheatCode.CODE_ACTIONS.Left
	if Input.is_action_just_pressed("rotate_down"):
		input_name = CheatCode.CODE_ACTIONS.Down
	if Input.is_action_just_pressed("rotate_right"):
		input_name = CheatCode.CODE_ACTIONS.Right
	
	if input_name:
		for code in cheat_codes:
			if code.check_code(input_name):
				if code.effect == "show_run_speed":
					$CheatsContainer/RunSpeedCheckButton.visible = true
				if code.effect == "show_high_jump":
					$CheatsContainer/HighJumpCheckButton.visible = true
				if code.effect == "show_fall_reset":
					$CheatsContainer/FallResetCheckButton.visible = true
				if code.effect == "show_size_change":
					$CheatsContainer/SizeChangeCheckButton.visible = true
				
				code_amount += 1
				$CheatsContainer/Label.text = "CHEATS (" + str(code_amount) + "/4 found)"
				
				if code_amount == 1:
					visible = true
