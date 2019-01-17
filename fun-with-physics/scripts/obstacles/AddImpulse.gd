extends StaticBody2D

const base_impulse = Vector2(1500, 1500)

func _add_impulse_to_projectile(projectile):
	var projectiles_velocity = projectile.linear_velocity
	var x_coord_impule_to_apply = base_impulse.x
	var y_coord_impule_to_apply = base_impulse.y
	if (projectiles_velocity.x < 0):
		x_coord_impule_to_apply = x_coord_impule_to_apply * -1
	if (projectiles_velocity.y < 0):
		y_coord_impule_to_apply = y_coord_impule_to_apply * -1	
	projectile.apply_impulse(Vector2(0,0), Vector2(x_coord_impule_to_apply, y_coord_impule_to_apply))