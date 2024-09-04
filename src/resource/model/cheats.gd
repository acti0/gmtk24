class_name Cheats extends Resource

var stats: PlayerStats = preload("res://src/resource/player_stats.tres")

## Whether cheats menu is available
@export var cheats_visible: bool = false:
	set(new_value):
		if new_value:
			cheats_visible = new_value
			emit_changed()

@export var high_jump: bool = false:
	set(new_value):
		if new_value:
			stats.jump_velocity = 25.0
		else:
			stats.jump_velocity = 5.0
		high_jump = new_value
