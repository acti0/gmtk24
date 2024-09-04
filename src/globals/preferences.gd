extends Node

'''
All settings that can be adjusted
'''

var master_bus_idx = AudioServer.get_bus_index("Master")

func _ready() -> void:
	master_volume = AudioServer.get_bus_volume_db(master_bus_idx)

@export var mouse_sensitivity: float = 1.0

@export var master_volume: float = 0.5:
	set(new_value):
		if new_value >= 0.0 and new_value <= 1.0:
			AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(new_value))
			master_volume = new_value
