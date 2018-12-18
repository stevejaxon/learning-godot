extends Node2D

signal health_changed
signal dead

export (int) var max_health
export (int) var armor
export (int) var agility
export (int) var luck

var health

func _ready():
	health = max_health
	_notify_ui_of_health_change(health)
	randomize()

func take_damage(amount):
	health -= amount - armor
	if health <= 0:
		_die()
		
func _notify_ui_of_health_change(health):	
	emit_signal("health_changed", health * 100/max_health) # Show the health as a percentage
	
func _die():
	emit_signal("dead")
	queue_free()