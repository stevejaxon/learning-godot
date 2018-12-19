extends Node2D

signal shoot

export (PackedScene) var Projectile
export (float) var weapon_cooldown
export (float) var vision
export (int) var damage

var target
var can_shoot = true # tracks whether the weapon cooldown has finished or not

func _ready():
	$WeaponTimer.wait_time = weapon_cooldown
	var circle = CircleShape2D.new()
	circle.radius = vision
	$Range/CollisionShape2D.shape = circle
	
func _process(delta):
	control(delta)
	
func aim(delta):
	var target_dir = (target.global_position - global_position).normalized()
	var current_dir = Vector2(1, 0).rotated($Turret.global_rotation)
	$Turret.global_rotation = current_dir.linear_interpolate(target_dir, 1 * delta).angle()

func shoot():
	if can_shoot:
		can_shoot = false
		$WeaponTimer.start()
		var direction = Vector2(1,0).rotated($Turret.global_rotation)
		emit_signal('shoot', Projectile, $Turret/Muzzel.global_position, direction, damage)
		
func _on_WeaponTimer_timeout():
	can_shoot = true # weapon cooldown timer has finished

func control(delta):
	if target != null:
		aim(delta)
		shoot()
	
func _on_Range_body_entered(body):
	target = body

func _on_Range_body_exited(body):
	target = null
