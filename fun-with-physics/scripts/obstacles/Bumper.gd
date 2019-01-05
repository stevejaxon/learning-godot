extends "res://scripts/obstacles/AddImpulse.gd"

export (int) var hits_remaining = -1

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("bump")	

func _on_Area2D_body_exited(body):
	_add_impulse_to_projectile(body)
	_reduce_hits_remaining()
	
func _reduce_hits_remaining():
	# -1 hits_remaining denotes the bumper will not disappear
	if hits_remaining > 0:
		if hits_remaining - 1 == 0:
			$AnimationPlayer.play("depleated")
		else:
			hits_remaining = hits_remaining - 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "depleated":
		queue_free()