extends Node2D

func _ready():
	$Projectile.apply_impulse(Vector2(0,0), Vector2(1000, 1000))
	$Projectile.show()