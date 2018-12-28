extends Node2D

onready var start_pos = $StartPosition.position
onready var end_pos = $EndPosition.position
onready var nav = $Navigation2D

export (PackedScene) var Creep;

func _ready():
	_spawn_creep()
	
func _spawn_creep():
	var c = Creep.instance()
	c.init(nav, start_pos, end_pos)
	add_child(c)