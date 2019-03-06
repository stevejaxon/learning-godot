extends Node2D

signal new_random_number
signal move_player

func _ready():
	randomize()
	self.connect("new_random_number", $Spinner, "spin")
	self.connect("move_player", $Base, "movePlayer")
	#TODO remove hardcoded turns
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")
	yield(_take_turn($Base.PLAYER_1), "completed")

func _take_turn(player):
	#var rand = randi() % 6
	var rand = 2
	emit_signal("new_random_number", rand)
	yield($Spinner, "spin_animation_finished")
	emit_signal("move_player", player, _mapRandomNumberToVector2(rand))
	#TODO figure out why the signal from a TileMap is not being fired or received
	#yield($Base, "player_move_finished")
	
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