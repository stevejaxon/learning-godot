extends RigidBody2D

	
func _trigger_disintigrate():
	_clean_up()
	
func _clean_up():
	hide()
	queue_free()