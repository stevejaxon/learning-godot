extends Node2D

func _process(delta):
	_aim()

func _aim():
	print(get_global_mouse_position())
	$Sprite.look_at(get_global_mouse_position())