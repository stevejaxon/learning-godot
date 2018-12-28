extends Node2D

signal shoot

export (PackedScene) var Projectile
export (float) var weapon_cooldown
export (float) var vision
export (int) var damage

var targets = []
var can_shoot = true # tracks whether the weapon cooldown has finished or not
var projectile_speed
var muzzel_start_position

func _ready():
	$WeaponTimer.wait_time = weapon_cooldown
	var circle = CircleShape2D.new()
	circle.radius = vision
	$Range/CollisionShape2D.shape = circle
	muzzel_start_position = $Turret/Muzzel.global_position
	# Since the Tower doesn't actually fire the projectile (it leaves it up to the main scene to do that) we need
	# to get an instance of the projectile to find out how fast it travels for later aiming calculations
	# The projectile_speed variable needs to be updated if the underlying projectile is modified mid-scene (e.g. upgraded)
	var temp_projectile = Projectile.instance()
	projectile_speed = temp_projectile.get_projectile_speed()
	temp_projectile.queue_free()
	$AnimationPlayer.play("init")
	
func _process(delta):
	control(delta)
	
func aim(delta):
	var target_dir = _calculate_where_to_aim_for_shot_to_hit(targets[0])
	$Turret.look_at(target_dir)

# Based on the solution found on StackOverflow: https://stackoverflow.com/a/2249237/8615465
func _calculate_where_to_aim_for_shot_to_hit(target):
	var muzzels_current_position = $Turret/Muzzel.global_position
	if ! target.get_ref():
		# target has recently been freed (killed and garbage collected), skip shooting this frame
		return muzzels_current_position
	else:
		target = target.get_ref()
	var target_velocity = target.get_velocity()
	var targets_current_position = target.get_global_position()	
	var a = _square(target_velocity.x) + _square(target_velocity.y) - _square(projectile_speed)
	var b = 2 * (target_velocity.x * (targets_current_position.x - muzzels_current_position.x) 
				+ target_velocity.y * (targets_current_position.y - muzzels_current_position.y))
	var c = _square(targets_current_position.x - muzzels_current_position.x) + _square(targets_current_position.y - muzzels_current_position.y)
	var discriminant = _square(b) - 4 * a * c
	var t
	if discriminant < 0:
		# It is not possible to hit the target, so leave the turret where it is (don't aim any more)
		return muzzels_current_position
	else:
		var t1 = (-b + sqrt(discriminant)) / (2*a)
		var t2 = (-b - sqrt(discriminant)) / (2*a)
		if t1 < 0 && t2 < 0:
			# Negative values mean it's not possible to hit the target - don't aim this time
			return muzzels_current_position
		elif t1 > 0 && t2 > 0:
			# both positive, so pick the smallest value for t
			t = min(t1, t2)
		else:
			# one is negative, so pick the positive value for t
			t = max(t1, t2)
	return t * target_velocity + targets_current_position

func _square(value):
	return value * value

func shoot():
	if can_shoot:
		can_shoot = false
		$WeaponTimer.start()
		var direction = Vector2(1,0).rotated($Turret.global_rotation)
		emit_signal('shoot', Projectile, $Turret/Muzzel.global_position, direction, damage)
		$AnimationPlayer.play("muzzle_flash")
		
func _on_WeaponTimer_timeout():
	can_shoot = true # weapon cooldown timer has finished

func control(delta):
	if targets.size() > 0:
		aim(delta)
		shoot()
	elif $Turret/Muzzel.global_position.x != muzzel_start_position.x:
		_reset_turret_position(delta)

func _reset_turret_position(delta):
	$Turret.global_rotation = 0
	
func _on_Range_body_entered(body):
	print("target aquired")
	targets.push_back(weakref(body))

func _on_Range_body_exited(body):
	print("target lost")
	targets.pop_front()
