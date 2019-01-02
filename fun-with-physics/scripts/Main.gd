extends Node2D

func _ready():
	$Projectile.apply_impulse($Projectile.global_position, Vector2(1000, 1000))
	$Projectile.show()