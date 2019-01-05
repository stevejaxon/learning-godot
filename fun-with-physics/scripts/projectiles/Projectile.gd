extends RigidBody2D

const min_velocity_delta = Vector2(0.1, 2)

var previous_velocity = Vector2()

func _physics_process(delta):
	if _has_shot_petered_out():
		_trigger_disintigrate()
	
func _has_shot_petered_out():
	if previous_velocity.x == 0 && previous_velocity.y == 0:
		previous_velocity = linear_velocity.abs()
	else:	
		var delta = previous_velocity - linear_velocity.abs()
		previous_velocity = linear_velocity.abs()
		return delta.x > 0 && delta < min_velocity_delta
	
func _trigger_disintigrate():
	_clean_up()
	
func _clean_up():
	hide()
	queue_free()