extends "res://scripts/Creep.gd"

onready var parent = get_parent()

func _init(_nav, _spawnPosition, _destination, _movement_speed = 100, _max_health=100, _armor=0, _agility=0, _luck=0).(_nav, _spawnPosition, _destination, _movement_speed, _max_health, _armor, _agility, _luck):
	_update_path()
	path.remove(0)
	
func _navigate(delta):
	prints("POSITION: ", position)
	prints("PATH: ", path)
#	if path.size() > 1:
#		var d = position.distance_to(path[0])
#		print(d)
#		if d > 2:
#			print("smooth moves")
#			velocity = move_and_slide(path[0])
#		else:
#			print("remove")
#			path.remove(0)

func _update_path():
	path = nav.get_simple_path(position, destination, false)
	if path.size() == 0:
		_reached_destination()

func _reached_destination():
	#TODO any broadcasting of signals to notify other actors that the destination was reached and animations
	queue_free()