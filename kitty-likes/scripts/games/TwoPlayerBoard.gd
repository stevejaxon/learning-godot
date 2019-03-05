extends Node2D

signal new_random_number
signal move_player

func _ready():
	randomize()
	self.connect("new_random_number", $Spinner, "spin")
	self.connect("move_player", $Base, "movePlayer")
	_take_turn($Base.PLAYER_1)
	
func _take_turn(player):
	#var rand = randi() % 6
	var rand = 0
	print(rand)
	emit_signal("new_random_number", rand)
	yield(get_node("Spinner"), "spin_animation_finished")
	print("spin finished")
	emit_signal("move_player", player, _mapRandomNumberToVector2(rand))
	
func _mapRandomNumberToVector2(rand):
	match rand:
		4:
			return Vector2(-1, -1)
		5: 
			return Vector2(1, -1)
		0:
			return Vector2(1, 0)
		1:
			return Vector2(1, 1)
		2: 
			return Vector2(-1, 1)
		3:
			return Vector2(-1, 0)