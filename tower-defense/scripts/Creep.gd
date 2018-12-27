extends KinematicBody2D

signal health_changed
signal dead

export (int) var movement_speed
export (int) var max_health
export (int) var armor
export (int) var agility
export (int) var luck
export (Vector2) var destination

var nav
var health
var velocity
var path = []

func init(_nav, _spawnPosition, _destination, _movement_speed = 100, _max_health=100, _armor=0, _agility=0, _luck=0):
	nav = _nav
	position = _spawnPosition
	destination = _destination
	movement_speed = _movement_speed
	max_health = _max_health
	armor = _armor
	agility = _agility
	luck = _luck
	
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
	