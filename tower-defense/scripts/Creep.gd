extends Node2D

signal health_changed
signal dead

export (int) var movement_speed
export (int) var max_health
export (int) var armor = 0
export (int) var agility = 0
export (int) var luck = 0
export (Vector2) var spawnPosition
export (Vector2) var destination

var health
var velocity

func _ready():
	health = max_health
	_notify_ui_of_health_change(health)
	randomize()
	
func _process(delta):
	_navigate(delta)
	
# Function to be overwritten by child scenes	
func _navigate():
	pass
	
func take_damage(amount):
	health = health - (amount - armor)
	_notify_ui_of_health_change(health)
	if health <= 0:
		_die()
		
# A simple solution to save towers having to calculate the velocity of the Creep
func get_velocity():
	return velocity
	
func _notify_ui_of_health_change(health):	
	emit_signal("health_changed", health * 100/max_health) # Show the health as a percentage
	
func _die():
	emit_signal("dead")
	queue_free()
	