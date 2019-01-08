extends Node2D

export (PackedScene) var ProjectileInstance
export (int) var ProjectileLaunchVelocity = 10

var can_fire = true

func _process(delta):
	if can_fire and Input.is_mouse_button_pressed(1):
		can_fire = false
		_launch_projectile()

func _launch_projectile():
	var launch_coordinates = $Turret/Muzzel.global_position
	var projectile = ProjectileInstance.instance()
	add_child(projectile)
	projectile.position = launch_coordinates
	projectile.apply_impulse(Vector2(0,0), Vector2(0,0))

func _on_PlayableAreaBoundary_ball_left_playable_area():
	print("exit light")
	can_fire = true
