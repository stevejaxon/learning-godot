extends StaticBody2D

func _on_Area2D_body_entered(body):
	_animate_destroyed()

func _animate_destroyed():
	$AnimationPlayer.play("destroyed")

func _on_AnimationPlayer_animation_finished(anim_name):
	_clean_up()

func _clean_up():
	queue_free()