extends RigidBody3D

var destination: Vector3
@export var speed: float = 5

## Set destination
func _ready() -> void:
	destination = position

## Movement
func _physics_process(delta: float) -> void:
	if destination != position:
		# Set position if close to endpoint
		if abs(destination - position) < Vector3(.2, 0, .2):
			position = destination
		
		# Move and get other tiles to move
		var gap = (destination - position).normalized() * speed * delta
		var collision: KinematicCollision3D = move_and_collide(gap)
		if collision:
			collision.get_collider().move((destination - position))

## Set new destination
func move(direction: Vector3) -> void:
	destination = (direction.normalized() * 3) + position


func _on_wall_extrusion_started() -> void:
	pass # Replace with function body.
