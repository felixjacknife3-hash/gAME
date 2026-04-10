extends Node
class_name JumpComponent

@export var character: Player
@export var jumpVel: float = 10
@export var wallJumpStrength = 60
@export var gravComponent: GravityComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if character.is_on_floor() and Input.is_action_just_pressed("Jump"):
		character.velocity.y = jumpVel
		gravComponent.gravScale = 1.0
	if character.is_on_wall_only():
		character.velocity.y = 0
		gravComponent.gravScale = 0.8
		if Input.is_action_just_pressed("Jump"):
			var normal = character.get_wall_normal()
			character.velocity = normal * wallJumpStrength
			character.velocity.y = jumpVel * 0.8
