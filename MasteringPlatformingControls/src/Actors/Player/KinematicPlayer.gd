extends KinematicBody2D

signal mark_position

const FLOOR_NORMAL = Vector2.UP
const PositionMarker = preload("res://src/Actors/Player/PositionMarker.tscn")
enum STATE {IDLE, RUNNING, JUMPING, FALLING, COYOTE_TIME, JUMP_BUFFER, WALL_SLIDE}

var gravity: float = 0
var vertical_acceleration: float = 0
var jump_impulse_amount: float = 0

var horizontal_force: float = 600
var horizontal_deceleration: float = 1300
var max_horizontal_speed: float = 200

const coyote_frames: int = 3
var current_frame_grace : int = 0

export var player_state: int = STATE.IDLE

var velocity = Vector2.ZERO

func _init():
	calculate_jump_variables(4 * 16, 0.44)

func _physics_process(delta):
	var horizontal_velocity = horizontal_force * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	# Slow down the player if they're not trying to move.
	if abs(horizontal_velocity) < horizontal_force * 0.2:
		velocity.x = move_toward(velocity.x, 0, horizontal_deceleration * delta)
	else:
		velocity.x += horizontal_velocity * delta
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -max_horizontal_speed, max_horizontal_speed)
	
	if Input.is_action_just_pressed("jump") and player_state == STATE.COYOTE_TIME:
		move_to_jump_state()
		display_marker(3)
	elif player_state == STATE.COYOTE_TIME and $CoyoteTimer.is_stopped():
		display_marker(2)
		move_to_falling_state()
		apply_gravity(delta)
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		move_to_jump_state() 
		display_marker(0)
	elif not is_on_floor() and player_state == STATE.RUNNING:
		if Input.is_action_just_pressed("jump"):
			move_to_jump_state()
			display_marker(3)
		else:
			display_marker(1)
			move_to_coyote_time_state()
	elif player_state == STATE.COYOTE_TIME:
		# Don't apply gravity
		pass
	elif player_state == STATE.FALLING and is_on_floor() and $JumpBufferTimer.time_left > 0:
		move_to_jump_state()
		display_marker(6)
		$JumpBufferTimer.stop()
	elif player_state == STATE.IDLE and abs(velocity.x) > 0 or player_state == STATE.FALLING and is_on_floor():
		move_to_running_state()
		apply_gravity(delta)
	elif velocity.y > 0 and (player_state == STATE.RUNNING or player_state == STATE.JUMPING):
		move_to_falling_state()
		apply_gravity(delta)
	elif is_on_floor() and horizontal_velocity == 0 and not player_state == STATE.IDLE:
		move_to_idel_state()
		apply_gravity(delta)
	else:
		if Input.is_action_just_pressed("jump") and $JumpBufferTimer.is_stopped():
			display_marker(4)
			$JumpBufferTimer.start()
		apply_gravity(delta)

	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, FLOOR_NORMAL)
	display_state()
	# velocity = move_and_slide(velocity, FLOOR_NORMAL)

func calculate_jump_variables(height: float, time: float) -> void:
	gravity = (2 * height) / pow(time, 2.0)
	jump_impulse_amount = sqrt(2 * gravity * height)

func display_marker(marker_type: int):
	var marker: PositionMarker = PositionMarker.instance()
	marker.set_global_position(global_position)
	marker.set_type(marker_type)
	emit_signal("mark_position", marker)

func move_to_jump_state() -> void:
	velocity.y = -jump_impulse_amount
	player_state = STATE.JUMPING

func move_to_falling_state() -> void:
	player_state = STATE.FALLING

func move_to_coyote_time_state() -> void:
	velocity.y = 0
	player_state = STATE.COYOTE_TIME
	$CoyoteTimer.start()

func move_to_running_state() -> void:
	player_state = STATE.RUNNING

func move_to_idel_state() -> void:
	player_state = STATE.IDLE

func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta

func display_state():
	match player_state:
		STATE.IDLE:
			set_modulate(Color(0,0,0,1))
		STATE.RUNNING:
			set_modulate(Color(0.86,0.3,0.3,1))
		STATE.COYOTE_TIME:
			set_modulate(Color(0.34, 0.08, 0.35, 1))
		STATE.FALLING:
			set_modulate(Color(0.08, 0.35, 0.2, 1))
		_:
			set_modulate(Color(1,1,1,1))
