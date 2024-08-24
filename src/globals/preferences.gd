extends Node

'''
All settings that can be adjusted
'''

signal cheats_changed

@export var mouse_sensitivity: float = 1

@export var cheats_active: bool = false:
	set(new_value):
		cheats_active = new_value
		cheats_changed.emit()
