extends Node3D
class_name HeadNode

@export_range(1, 5, 0.1) var sens = 2.2
@export_range(0.1, 1, 0.1) var deadzone = 0.2
@export var maxXRot = 89.0
@export var minXRot = -80.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sens))
		rotate_x(deg_to_rad(-event.relative.y * sens))

func _process(_delta: float) -> void:
	var lookX = Input.get_action_strength("LookRight") - Input.get_action_strength("LookLeft")
	var lookY = Input.get_action_strength("LookDown") - Input.get_action_strength("LookUp")
	
	var lookDir = Vector2(lookX, lookY)
	
	if lookDir.length() < deadzone:
		lookDir = Vector2.ZERO
	
	get_parent().rotate_y(deg_to_rad(-lookDir.x * sens))
	rotate_x(deg_to_rad(-lookDir.y * sens))
	
	rotation.x = clamp(rotation.x, deg_to_rad(minXRot), deg_to_rad(maxXRot))
