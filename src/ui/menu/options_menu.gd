extends Menu

@onready var mouse_sense_slider = %MouseSenseSlider
@onready var volume_slider = %VolumeSlider
@onready var volume_val = %VolumeValue

func _ready() -> void:
	volume_slider.value = Preferences.master_volume
	mouse_sense_slider.value = Preferences.mouse_sensitivity

func _on_reset_objects_pressed() -> void:
	EventBus.reset_objects.emit()

func _on_big_world_check_button_pressed() -> void:
	EventBus.big_world_toggled.emit()

func _on_mouse_sense_slider_drag_ended(value_changed: bool) -> void:
	Preferences.mouse_sensitivity = mouse_sense_slider.value

func _on_volume_slider_value_changed(value: float) -> void:
	Preferences.master_volume = value
	volume_val.text = str(value * 100)
