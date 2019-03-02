extends Node2D

signal new_random_number

func _ready():
	randomize()
	self.connect("new_random_number", $Spinner, "spin")
	var rand = randi() % 6
	print(rand)
	emit_signal("new_random_number", rand)