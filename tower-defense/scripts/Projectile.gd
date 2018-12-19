extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction, _damage):
	position = _position
	rotation = _direction.angle()
	damage = _damage
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	$Lifetime.start()
	
func _process(delta):
	position += velocity * delta
	
func get_projectile_speed():
	return speed
	
func expolode():
	velocity = Vector2() # The projectile is no longer moving
	$Sprite.hide()
	$ProjectileExplosion.show()
	$ProjectileExplosion/AnimationPlayer.play("explode")

func _on_Projectile_body_entered(body):
	expolode()
	if body.has_method('take_damage'):
		body.take_damage(damage)

func _on_Lifetime_timeout():
	$Lifetime.stop()
	$Lifetime.queue_free()
	expolode()

# Only indicate that the scene is ready to be garbage collected after the animation has finished playing
func _on_ProjectileExplosion_animation_finished():
	queue_free()
