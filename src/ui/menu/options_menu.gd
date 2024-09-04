extends Menu

var stats: PlayerStats = preload("res://src/resource/player_stats.tres")

@onready var mouse_sense_slider = %MouseSenseSlider
@onready var mouse_sense_val = %MouseSenseValue
@onready var volume_slider = %VolumeSlider
@onready var volume_val = %VolumeValue

func _ready() -> void:
	volume_slider.value = Preferences.master_volume
	mouse_sense_slider.value = stats.mouse_sensitivity

func _on_reset_objects_pressed() -> void:
	EventBus.reset_objects.emit()

func _on_big_world_check_button_pressed() -> void:
	EventBus.big_world_toggled.emit()

func _on_mouse_sense_slider_value_changed(value: float) -> void:
	stats.mouse_sensitivity = value
	mouse_sense_val.text = str(value)

func _on_volume_slider_value_changed(value: float) -> void:
	Preferences.master_volume = value
	volume_val.text = str(value * 100)
