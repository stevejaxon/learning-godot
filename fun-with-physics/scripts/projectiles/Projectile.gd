extends RigidBody2D

func _physics_process(delta):
	if _has_shot_petered_out():
		_trigger_disintigrate()
	
func _has_shot_petered_out():
	return angular_velocity > 0 && angular_velocity < 5
	
func _trigger_disintigrate():
	pass
	
func _clean_up():
	hide()
	queue_free()