extends Node2D

signal ball_left_playable_area

func _on_Area2D_body_entered(body):
	emit_signal("ball_left_playable_area")
