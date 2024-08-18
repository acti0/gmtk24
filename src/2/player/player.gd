extends CharacterBody3D

@onready var player_controller = %PlayerController

var grow_speed: float = 1
var growing: bool = false

func grow() -> void:
	growing = true
	#player_controller.set_process(false)

func _physics_process(delta: float) -> void:
	if growing:
		scale += scale * grow_speed * delta
		if scale.y > 1.0:
			scale = Vector3(1, 1, 1)
			growing = false
			#player_controller.set_process(true)
