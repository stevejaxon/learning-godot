extends "res://scripts/Creep.gd"

onready var parent = get_parent()

func _navigate(delta):
	if parent is PathFollow2D:
		parent.set_offset(parent.get_offset() + movement_speed * delta)
		position = Vector2()