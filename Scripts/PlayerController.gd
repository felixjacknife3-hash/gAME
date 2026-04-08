extends Node
class_name PlayerMovementComponent

@export var runSpeed: float = 10
@export var baseSpeed: float = 6
@export var character: Player

var speed := 6.0

func _physics_process(_delta: float) -> void:
	# inputs
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var dir := (character.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if dir:
		direction(dir)
	else:
		slowDown()

func direction(dir: Vector3) -> void:
	character.velocity.x = dir.x * (speed)
	character.velocity.z = dir.z * (speed)

func slowDown() -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, speed)
	character.velocity.z = move_toward(character.velocity.z, 0, speed)
