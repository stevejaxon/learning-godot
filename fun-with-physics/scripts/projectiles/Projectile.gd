extends RigidBody2D

func _physics_process(delta):
	if _has_shot_petered_out():
		_trigger_disintigrate()
	
func _has_shot_petered_out():
	print(linear_velocity)
	print(angular_velocity)
	if angular_velocity > 0:
		return angular_velocity < 1
	elif angular_velocity < 0: 
		return angular_velocity > -1
	
func _trigger_disintigrate():
	_clean_up()
	
func _clean_up():
	hide()
	queue_free()