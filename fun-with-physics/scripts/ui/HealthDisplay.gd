extends Node2D

#var bar_low_health = preload("")
#var bar_full_health = preload("")
#var bar_taken_damage = preload("")

func _process(delta):
	global_rotation = 0 # prevent the health bar rotating with any attached units

func update_health_bar(value):
	# $HealthBar.texture_progress = bar_full_health
	if value < 25:
		# TODO
		$HealthBar.texture_progress 
	elif value < 100:
		# TODO
		$HealthBar.texture_progress
	$HealthBar.value = value