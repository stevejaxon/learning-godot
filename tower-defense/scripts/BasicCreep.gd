extends "res://scripts/Creep.gd"

onready var parent = get_parent()

func _navigate(delta):
	velocity = move_and_slide(Vector2(-movement_speed, movement_speed))