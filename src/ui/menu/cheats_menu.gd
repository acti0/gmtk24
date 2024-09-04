extends Menu

func _on_cheats_check_button_pressed() -> void:
	Preferences.cheats_active = !Preferences.cheats_active
