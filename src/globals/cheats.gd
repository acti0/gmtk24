extends Node

var stats: PlayerStats = preload("res://src/resource/player_stats.tres")

## Dis- / Enable death plane
func toggle_death_plane() -> void:
	var death_plane = get_tree().get_first_node_in_group("death_plane")
	if death_plane.process_mode == Node.PROCESS_MODE_INHERIT:
		death_plane.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		death_plane.process_mode = Node.PROCESS_MODE_INHERIT

func toggle_size_change() -> void:
	stats.allow_self_growth = !stats.allow_self_growth

@export var run_speed: bool = false:
	set(new_value):
		if new_value:
			stats.sprint_speed = 15.0
		else:
			stats.sprint_speed = 7.5
		run_speed = new_value

@export var high_jump: bool = false:
	set(new_value):
		if new_value:
			stats.jump_velocity = 25.0
		else:
			stats.jump_velocity = 5.0
		high_jump = new_value

@export var object_collision: bool = false:
	set(new_value):
		if new_value:
			pass
		else:
			pass
		object_collision = new_value
