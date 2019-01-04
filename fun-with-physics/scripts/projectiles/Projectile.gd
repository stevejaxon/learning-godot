extends RigidBody2D

func _physics_process(delta):
	print(angular_velocity)
	if _has_shot_petered_out():
		_trigger_disintigrate()
	
func _has_shot_petered_out():
	return angular_velocity > 0 && angular_velocity < 1 or angular_velocity < 0 && angular_velocity > -1
	
func _trigger_disintigrate():
	_clean_up()
	pass
	
func _clean_up():
	hide()
	queue_free()