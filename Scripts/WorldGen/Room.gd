@abstract
extends Node3D
class_name Room

@export_enum("S", "M", "L", "XL") var size = "M"
@export var rooms: RoomsArray
@export var area: Area3D

func nextRoom() -> void:
	pass

func getRandInt(from: int = 0, to: int = 10) -> int:
	var rng = RandomNumberGenerator.new()
	var num = rng.randi_range(from, to)
	
	return num

func isOverlapping() ->  bool:
	return area.get_overlapping_areas().size() > 0
