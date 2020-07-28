extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP

var gravity: float = 0
var vertical_acceleration: float = 0
var jump_impulse_amount: float = 0

var horizontal_force: float = 600
var horizontal_deceleration: float = 1300
var max_horizontal_speed: float = 200

var velocity = Vector2.ZERO

onready var initial_position = global_position

func _init():
	calculate_jump_variables(4 * 16, 0.44)

func _physics_process(delta):
	var walk = horizontal_force * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	# Slow down the player if they're not trying to move.
	if abs(walk) < horizontal_force * 0.2:
		velocity.x = move_toward(velocity.x, 0, horizontal_deceleration * delta)
	else:
		velocity.x += walk * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_impulse_amount
	else:
		velocity.y += gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, FLOOR_NORMAL)
	# velocity = move_and_slide(velocity, FLOOR_NORMAL)

func calculate_jump_variables(height: float, time: float) -> void:
	var delta = 1.0 / ProjectSettings.get_setting("physics/common/physics_fps")
	gravity = (2 * height) / pow(time, 2.0)
	jump_impulse_amount = sqrt(2 * gravity * height)
	
	print("gravity: " + str(gravity))
	print("jump_vel: " + str(jump_impulse_amount))
