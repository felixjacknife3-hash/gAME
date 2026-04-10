@icon("res://Icons/Bullet.png")
extends Node
class_name ShootComponent 

@export var cam: Camera3D
@export var character: Player
@export var debound: float = 0.1
@export var recoilMulti: float = 2.2
@export var maxRecoilRange: float = 80

var t := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	if Input.is_action_pressed("Shoot") and t > debound:
		t = 0
		shoot()

func shoot() -> void:
	var mousePos = get_viewport().get_mouse_position()
	var dir = cam.project_ray_normal(mousePos).normalized() # THIS is your shot direction
	
	var query = ray(1000000)
	
	if !query.is_empty():
		var pos = query.get("position")
		var distToPos = character.global_position.distance_to(pos)
		
		var percent = -(distToPos / maxRecoilRange) + 1 
		
		if distToPos <= maxRecoilRange:
			var recoil = -dir # opposite direction
			recoil *= recoilMulti
			recoil *= percent
			
			character.velocity += recoil

func ray(length: float) -> Dictionary:
	var mousePos = get_viewport().get_mouse_position()
	var from = cam.project_ray_origin(mousePos)
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
