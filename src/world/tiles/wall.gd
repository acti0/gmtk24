extends RigidBody3D

signal extrusion_started

func scale_up(collision_point: Vector3) -> void:
	# Check if collision was on inner side
	if to_local(collision_point).x < 0:
		hide()
		$CollisionShape3D.disabled = true
		extrusion_started.emit()
