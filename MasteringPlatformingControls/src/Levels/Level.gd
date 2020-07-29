extends Node2D

func _ready():
	$Character.connect("mark_position", self, "add_child")
