extends Area2D

export (int) var speed
export (int) var damage
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = lifetime
	velocity = _direction * speed
	
func _process(delta):
	position += velocity * delta
	

func expolode():
	velocity = Vector2() # The projectile is no longer moving
	$Sprite.hide()
	$ProjectileExplosion.show()
	$ProjectileExplosion.play("explode")

func _on_Projectile_body_entered(body):
	expolode()
	if body.has_method('take_damage'):
		body.take_damage(damage)

func _on_Lifetime_timeout():
	expolode()

# Only indicate that the scene is ready to be garbage collected after the animation has finished playing
func _on_ProjectileExplosion_animation_finished():
	queue_free()
