extends CharacterBody3D

var grow_speed: float = 1
var growing: bool = false

## Start growing player to scale = 1
func grow() -> void:
	growing = true

## Grow the player back
func _physics_process(delta: float) -> void:
	if growing:
		scale += scale * grow_speed * delta
		if scale.y > 1.0:
			scale = Vector3(1, 1, 1)
			growing = false
