extends Room
class_name StartRoom

@export var endMarker: Marker3D

func nextRoom() -> void:
	var scn = rooms.middle.pick_random()
	var instance = scn.instantiate()
	
	if instance is MiddleRoom:
		add_child(instance)
		instance.rooms = rooms
		instance.position = endMarker.position
		instance.rotation = endMarker.rotation
		instance.nextRoom()
