extends Menu

@onready var audio = $AudioStreamPlayer

func _on_start_button_pressed() -> void:
	close()

func close() -> void:
	audio.stop()
	super.close()
