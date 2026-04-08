@icon("res://Icons/Bullet.png")
extends Node
class_name ShootComponent 

@export var cam: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func shoot() -> void:
	var query = ray(1000000)
	if !query.is_empty():
		var pos = query.get("position")
		var collider = query.get("collider")
		if collider is Enemy:
			pass

func ray(length: float) -> Dictionary:
	var mousePos = get_viewport().get_mouse_position()
	var from = cam.position
	var to = from + cam.project_ray_normal(mousePos) * length
	
	var rayParams = PhysicsRayQueryParameters3D.create(
		from,
		to
	)
	var space = cam.get_world_3d().direct_space_state
	var rayQuery = space.intersect_ray(rayParams)
	if !rayQuery.is_empty():
		return rayQuery
	return {}
