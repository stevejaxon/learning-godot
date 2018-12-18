extends Node

signal explosion_animation_completed

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		emit_signal("explosion_animation_completed")
