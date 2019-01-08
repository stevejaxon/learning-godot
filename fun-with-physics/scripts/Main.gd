extends Node2D

export (PackedScene) var ProjectileInstance
export (int) var ProjectileMaxLaunchVelocity = 800

# Godot defaults to pointing to the right as 0 degrees rotation. 
# We want facing directly down to be 0 degrees rotation.
const TURRET_ROTATION_OFFSET = 90
const MAX_X_IMPULE_PERCENTAGE = 80

var can_fire = true

func _process(delta):
	if can_fire and Input.is_mouse_button_pressed(1):
		can_fire = false
		_launch_projectile()

func _launch_projectile():
	var launch_coordinates = $Turret/Muzzel.global_position
	var projectile = ProjectileInstance.instance()
	$PlayableAreaBoundary.connect("ball_left_playable_area", projectile, "_trigger_disintigrate")
	add_child(projectile)
	projectile.position = launch_coordinates
	projectile.apply_impulse(Vector2(0,0), _calculate_impulse_to_apply())

func _calculate_impulse_to_apply():
	var rotation = $Turret.global_rotation_degrees - TURRET_ROTATION_OFFSET
	var rotation_percentage = (abs(rotation) / 90) * 100
	var x_impulse_percentage = min(MAX_X_IMPULE_PERCENTAGE, rotation_percentage)
	var x_impulse_amount = ProjectileMaxLaunchVelocity * (x_impulse_percentage / 100)
	var y_impulse_amount = ProjectileMaxLaunchVelocity - x_impulse_amount
	
	if (rotation > 0):
		return Vector2(-x_impulse_amount, y_impulse_amount)
	else: 
		return Vector2(x_impulse_amount, y_impulse_amount)

func _on_PlayableAreaBoundary_ball_left_playable_area():
	can_fire = true
