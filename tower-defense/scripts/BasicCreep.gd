extends "res://scripts/Creep.gd"

onready var parent = get_parent()

func _ready():
	_update_path()
	path.remove(0)
	
func _navigate(delta):
	if path.size() > 1:
		var d = position.distance_to(path[0])
		if d > 16:
			velocity = move_and_slide(path[0] - position)
		else:
			path.remove(0)
			velocity = move_and_slide(path[0] - position)
		prints("delta: ", path[0] - position)
		prints("velocity", velocity)

func _update_path():
	path = nav.get_simple_path(position, destination, false)
	if path.size() == 0:
		_reached_destination()

func _reached_destination():
	#TODO any broadcasting of signals to notify other actors that the destination was reached and animations
	queue_free()