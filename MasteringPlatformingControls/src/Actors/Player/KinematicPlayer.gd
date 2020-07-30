extends KinematicBody2D

signal mark_position

const FLOOR_NORMAL = Vector2.UP
const PositionMarker = preload("res://src/Actors/Player/PositionMarker.tscn")

var gravity: float = 0
var vertical_acceleration: float = 0
var jump_impulse_amount: float = 0

var horizontal_force: float = 600
var horizontal_deceleration: float = 1300
var max_horizontal_speed: float = 200

const coyote_frames: int = 3
var current_frame_grace : int = 0

var is_jumping: bool = false

var velocity = Vector2.ZERO

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

	
	if Input.is_action_just_pressed("jump") and (is_on_floor() or not $CoyoteTimer.is_stopped()): 
		velocity.y = -jump_impulse_amount
		is_jumping = true
		if is_on_floor():
			display_marker(0)
		else:
			display_marker(1)
		$CoyoteTimer.stop()
	elif not is_on_floor() and not is_jumping and $CoyoteTimer.is_stopped():
		velocity.y = 0
		$CoyoteTimer.start()
	else:
		if is_on_floor():
			is_jumping = false
		velocity.y += gravity * delta

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, FLOOR_NORMAL)
	# velocity = move_and_slide(velocity, FLOOR_NORMAL)

func calculate_jump_variables(height: float, time: float) -> void:
	var delta = 1.0 / ProjectSettings.get_setting("physics/common/physics_fps")
	gravity = (2 * height) / pow(time, 2.0)
	jump_impulse_amount = sqrt(2 * gravity * height)

func _on_PositionMarkerTimer_timeout():
	display_marker(0)

func display_marker(marker_type: int):
	var marker: PositionMarker = PositionMarker.instance()
	marker.set_global_position(global_position)
	marker.set_type(marker_type)
	emit_signal("mark_position", marker)
