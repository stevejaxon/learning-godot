extends "res://scripts/obstacles/AddImpulse.gd"

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("bump")

func _on_Area2D_body_exited(body):
	_add_impulse_to_projectile(body)