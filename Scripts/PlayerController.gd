extends CharacterBody3D
class_name Player

@export var runSpeed: float = 10
@export var baseSpeed: float = 6
@export var jumpVel: float = 10
@export var wallJumpStr: float = 60

var speed := 6.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	jump()
	wallInteractions(delta)
	move_and_slide()

func wallInteractions(delta):
	if !is_on_wall_only(): return
	velocity.y = 0
	velocity.y += get_gravity().y * delta * 0.4
	if Input.is_action_just_pressed("Jump"):
		velocity = get_wall_normal() * wallJumpStr
		velocity.y = jumpVel * 1.2

func jump():
	if Input.is_action_pressed("Jump") and is_on_ceiling():
		velocity.y = jumpVel
	elif Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = jumpVel
