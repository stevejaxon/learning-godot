extends Control

# The spinner works on a hexadecemal, isometric grid of numbers from 0 - 5 around a position e.g. if the player is in the position X then the position is numbered as such:
#
# 4   5
# 3 X 0
# 2   1
#
# A random number in this range will decide which direction the player moves next turn.

func _init(result):
	spin(result)
	
func spin(result):
	yield(_baseSpin(), "completed")
	yield(_finalTicks(result), "completed")

func _baseSpin():
	yield(_playFastSpin(), "completed")
	yield(_playMediumSpin(), "completed")
	yield(_playMediumSlowSpin(), "completed")
	
func _finalTicks(result):
	match result:
		0:
			yield(_playSlowTick(1, 5), "completed")
			yield(_playSlowTick(2, 5), "completed")
			yield(_playSlowTick(3, 4), "completed")
			yield(_playSlowTick(4, 3), "completed")
			yield(_playSlowTick(5, 2), "completed")
			yield(_playSlowTick(0, 1), "completed")
		1:
			yield(_playSlowTick(1, 1), "completed")
		2:
			yield(_playSlowTick(1, 2), "completed")
			yield(_playSlowTick(2, 1), "completed")
		3:
			yield(_playSlowTick(1, 3), "completed")
			yield(_playSlowTick(2, 2), "completed")
			yield(_playSlowTick(3, 1), "completed")
		4:
			yield(_playSlowTick(1, 4), "completed")
			yield(_playSlowTick(2, 3), "completed")
			yield(_playSlowTick(3, 2), "completed")
			yield(_playSlowTick(4, 1), "completed")
		5:
			yield(_playSlowTick(1, 5), "completed")
			yield(_playSlowTick(2, 4), "completed")
			yield(_playSlowTick(3, 3), "completed")
			yield(_playSlowTick(4, 2), "completed")
			yield(_playSlowTick(5, 1), "completed")
	
func _playFastSpin():
	yield(_playFullSpin(15), "completed")
	
func _playMediumSpin():
	yield(_playFullSpin(10), "completed")
	
func _playMediumSlowSpin():
	yield(_playFullSpin(5), "completed")
	
func _playSlowTick(number, speed):
	$AnimationPlayer.play(String(number), -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	
func _playFullSpin(speed):
	$AnimationPlayer.play("1", -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("2", -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("3", -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("4", -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("5", -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	$AnimationPlayer.play("0", -1, speed)
	yield(get_node("AnimationPlayer"), "animation_finished")
	