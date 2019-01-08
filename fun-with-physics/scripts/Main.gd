extends Node2D

export (PackedScene) var ProjectileInstance
export (int) var ProjectileLaunchVelocity = 300

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
	projectile.apply_impulse(Vector2(0,0), Vector2(0,ProjectileLaunchVelocity))

func _on_PlayableAreaBoundary_ball_left_playable_area():
	can_fire = true
