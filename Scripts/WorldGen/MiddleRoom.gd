extends Room
class_name MiddleRoom

@export var sideMarker: Marker3D
@export var endMarker: Marker3D

func sideRoom() -> void:
	var scn = rooms.side.pick_random()
	if !(scn is PackedScene): return
	var instance = scn.instantiate()
	
	await get_tree().process_frame
	if instance is SideRoom:
		if instance.isOverlapping(): 
			instance.queue_free()
			return
		add_child(instance)
		instance.rooms = rooms
		instance.position = sideMarker.position
		instance.rotation = sideMarker.rotation

func endRoom() -> void:
	print("EndRoom")
	var scn = rooms.end.pick_random()
	if !(scn is PackedScene): return
	var instance = scn.instantiate()
	
	if instance is EndRoom:
		add_child(instance)
		instance.rooms = rooms
		instance.position = endMarker.position
		instance.rotation = endMarker.rotation
	else:
		endRoom()

func nextRoom() -> void:
	if sideMarker and getRandInt(1, 8) == 1: sideRoom()
	if getRandInt(1, 16) == 1:
		endRoom()
		return
	var scn = rooms.middle.pick_random()
	if !(scn is PackedScene): return
	var instance = scn.instantiate()
	
	await get_tree().physics_frame
	if instance is MiddleRoom:
		if instance.isOverlapping(): 
			instance.queue_free()
			var parent = get_parent()
			if parent is MiddleRoom:
				parent.endRoom()
				queue_free()
			print("overlapping")
			return
		add_child(instance)
		instance.rooms = rooms
		instance.position = endMarker.position
		instance.rotation = endMarker.rotation
		instance.nextRoom()
	else:
		nextRoom()
	
