extends Area3D

## Set object back on stage and grow it
func _on_body_entered(body: Node3D) -> void:
	body.scale = body.scale / 20
	body.global_position = (body.global_position / 20) + Vector3(0, 0.5, 0)
	## Change spawn position for BaseObject to avoid it clipping into the ground?
	if body is BaseObject:
		body.global_position += ((body.global_position - Vector3(0, 0, 0)).normalized() * 2) + Vector3(0, 0.5, 0)
	body.grow()
