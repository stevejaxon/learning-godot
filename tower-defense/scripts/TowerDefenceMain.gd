extends Node2D



func _on_Tower_shoot(Projectile, _position, _direction, _damage):
	var p = Projectile.instance()
	add_child(p)
	p.start(_position, _direction, _damage)


func _on_CreepEmitter_new_creep(enemy):
	add_child(enemy)
