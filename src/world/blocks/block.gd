extends Node3D

var destination: Vector3
@export var speed: float = 5
@export var max_tiles: int = 4

## Set destination
func _ready() -> void:
	destination = position
	#for child in get_children():
	#	child.move_triggered.connect(move)

## Movement
func _physics_process(delta: float) -> void:
	if destination != position:
		# Set position if close to endpoint
		if abs(destination - position) < Vector3(.2, 0, .2):
			position = destination
		
		# Move block
		var gap = (destination - position).normalized() * speed * delta
		position += gap

## Set new destination
func move(direction: Vector3) -> void:
	destination = (direction.normalized() * 3) + position
