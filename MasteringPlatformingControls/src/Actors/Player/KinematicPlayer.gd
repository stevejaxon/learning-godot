extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")

var vertical_acceleration: float = 0
var jump_impulse_amount: float = 200

var horizontal_force: float = 600
var horizontal_deceleration: float = 1300
var max_horizontal_speed: float = 200

var velocity = Vector2.ZERO

func _physics_process(delta):
	var walk = horizontal_force * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < horizontal_force * 0.2:
		velocity.x = move_toward(velocity.x, 0, horizontal_deceleration * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)

	velocity.y += gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, FLOOR_NORMAL)
	# velocity = move_and_slide(velocity, FLOOR_NORMAL)

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_impulse_amount


