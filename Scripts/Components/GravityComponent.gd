@icon("res://Icons/Gravity.png")
extends Node
class_name GravityComponent

@export var character: CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !character.is_on_floor():
		character.velocity.y -= gravity * delta
