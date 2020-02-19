extends Area2D


signal pickup
signal hurt

export (int) var speed
var velocity = Vector2()
var screensize = Vector2(480, 720)
var isHurt = false

func _process(delta):
	get_input()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = velocity.x < 0
	elif !isHurt:
		$AnimatedSprite.play("idle")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func start(pos):
	set_process(true)
	$AnimatedSprite.show()
	isHurt = false
	position = pos
	$AnimatedSprite.play("idle")
	
func stop():
	set_process(false)
	isHurt = true
	$AnimatedSprite.play("hurt")
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.hide()

func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup", "coin")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
	if area.is_in_group("powerups"):
		area.pickup()
		emit_signal("pickup", "powerup")


func _on_AnimatedSprite_animation_finished():
	print($AnimatedSprite.animation)
