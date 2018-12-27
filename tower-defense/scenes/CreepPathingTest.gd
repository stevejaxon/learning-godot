extends Node2D

onready var start_pos = $StartPosition.position
onready var end_pos = $EndPosition.position
onready var nav = $Navigation2D

var Creep = preload("res://scripts/BasicCreep.gd")

func _ready():
	_spawn_creep()
	
func _spawn_creep():
	var c = Creep.new(nav, start_pos, end_pos)
	add_child(c)