extends RigidBody2D

func _ready():
	$AnimationPlayer.play("Spin")
	
func _trigger_disintigrate():
	_clean_up()
	
func _clean_up():
	hide()
	queue_free()

func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.play("Spin")
