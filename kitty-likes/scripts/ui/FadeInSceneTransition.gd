extends ColorRect

signal transition_finished

func transition():
	show()
	$AnimationPlayer.play("FadeIn")
	yield(get_node("AnimationPlayer"), "animation_finished")