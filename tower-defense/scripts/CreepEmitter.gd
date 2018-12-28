extends Node2D

signal new_creep

export (int) var total_number_of_enemies = 1
export (float) var spawn_interval = 0.5
export (PackedScene) var Creep

var emittedCount = 0

func _ready():
	$EmitterInterval.set_wait_time(spawn_interval)
	$EmitterInterval.start()

func _on_EmitterInterval_timeout():
	if emittedCount != total_number_of_enemies:
		_spawn_creep()
	else:
		_on_wave_finished()

func _spawn_creep():
	var c = Creep.instance()
	c.init(get_parent().get_node("Navigation2D"), get_parent().get_node("StartPosition").position, get_parent().get_node("EndPosition").position)
	emit_signal("new_creep", c)
	emittedCount = emittedCount + 1
	
func _on_wave_finished():
	$EmitterInterval.stop()
	$EmitterInterval.queue_free()
	queue_free()