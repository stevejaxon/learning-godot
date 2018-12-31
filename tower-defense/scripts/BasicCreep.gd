extends "res://scripts/Creep.gd"

onready var parent = get_parent()

func _ready():
	_update_path()
	path.remove(0)
	
func _navigate(delta):	
	if path.size() > 1:
		var d = position.distance_to(path[0])
		if d < 1:
			# The Creep has moved to close to the current path node, so switch to moving towards the next one 
			path.remove(0)
		else:			
			var positionBefore = position
			position = position.linear_interpolate(path[0], (movement_speed * delta) / d)
			velocity = (position - positionBefore) * 60		

func _update_path():
	path = nav.get_simple_path(position, destination, false)
	if path.size() == 0:
		_reached_destination()

func _reached_destination():
	#TODO any broadcasting of signals to notify other actors that the destination was reached and animations
	queue_free()