extends StaticBody2D

func _on_Area2D_body_entered(body):
	print(body)
	print("FOO")
	$AnimationPlayer.play("destroyed")

func _on_AnimationPlayer_animation_finished(anim_name):
	print("finished")
	_clean_up()

func _clean_up():
	print("clean")
	queue_free()