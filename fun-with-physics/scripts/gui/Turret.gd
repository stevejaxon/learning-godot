extends Node2D

func _process(delta):
	_aim()

func _aim():
	look_at(get_global_mouse_position())