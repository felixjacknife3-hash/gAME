extends Room
class_name RoomBuilder

func nextRoom() -> void:
	var scn = rooms.start.pick_random()
	var instance = scn.instantiate()
	
	if instance is StartRoom:
		add_child(instance)
		instance.rooms = rooms
		instance.position = position
		instance.rotation = rotation
		instance.nextRoom()

func _ready() -> void:
	nextRoom()
