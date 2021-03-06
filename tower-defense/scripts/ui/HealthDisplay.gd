extends Node2D

var bar_full_health = preload("res://assets/ui/barHorizontal_green_mid 200.png")
var bar_taken_damage = preload("res://assets/ui/barHorizontal_yellow_mid 200.png")
var bar_low_health = preload("res://assets/ui/barHorizontal_red_mid 200.png")

func _ready():
	$HealthBar.hide() # Start off with the healtbar hidden when units are on full health

func _process(delta):
	global_rotation = 0 # prevent the health bar rotating with any attached units

func update_health_bar(value):	
	if value < 25:
		$HealthBar.texture_progress = bar_low_health
	elif value < 60:
		$HealthBar.texture_progress = bar_taken_damage
	else:
		$HealthBar.texture_progress = bar_full_health
		if value < 100:
			$HealthBar.show()
	$HealthBar.value = value