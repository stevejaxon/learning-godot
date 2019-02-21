extends Node2D

# The spinner works on a 3x3 grid of numbers from 0 - 7 around a position e.g. if the player is in the grid position X then the position is numbered as such:
#
# 0 1 2
# 7 X 3
# 6 5 4
#
# A random number in this range will decide which direction the player moves next turn.

# Constants
const FAST_ROTATION_SPEED = PI/8
const FAST_NUM_QUADRANTS = 48 # 3 complete rotations
const MEDIUM_ROTATION_SPEED = PI/16
const MEDIUM_NUM_QUADRANTS = 112 # FAST (48) + MEDIUM (64)
const SLOW_ROTATION_SPEED = PI/32
const SLOW_NUM_QUADRANTS = 176 # FAST (48) + MEDIUM (64) + SLOW (64)
const SLOW_TO_A_STOP_ROTATION_SPEED =PI/64

var total_num_quadrants = 0
var num_slow_quadrants;
var num_slow_to_a_stop_quadrants;
var random_result;

func _init():
	randomize()
	random_result = randi() % 7 # Random number in the range 0 - 7 inclusive
	prints("random number", random_result)
	num_slow_quadrants = SLOW_NUM_QUADRANTS +  _calculate_required_quadrants_at_slow_speed(random_result)
	num_slow_to_a_stop_quadrants = num_slow_quadrants + 16

func _calculate_required_quadrants_at_slow_speed(result):
	match result:
		4: 
			return 0
		5: 
			return 8
		6: 
			return 16
		7:
			return 24
		0:
			return 32
		1:
			return 40
		2:
			return 48
		3:
			return 56

func _process(delta):
	var rotate_speed;
	
	if total_num_quadrants < FAST_NUM_QUADRANTS:
		rotate_speed = FAST_ROTATION_SPEED
	elif total_num_quadrants < MEDIUM_NUM_QUADRANTS:
		rotate_speed = MEDIUM_ROTATION_SPEED
	elif total_num_quadrants < num_slow_quadrants:
		rotate_speed = SLOW_ROTATION_SPEED
	elif total_num_quadrants < num_slow_to_a_stop_quadrants:
		rotate_speed = SLOW_TO_A_STOP_ROTATION_SPEED
	else:
		rotate_speed = 0
	$Sprite.rotate(rotate_speed)
	total_num_quadrants = total_num_quadrants + 1