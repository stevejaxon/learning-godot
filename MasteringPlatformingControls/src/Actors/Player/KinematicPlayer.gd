extends KinematicBody2D

const FLOOR_NORMAL = Vector2.UP

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")

var vertical_acceleration: float = 0
var jump_impulse_amount: float = 0

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity * delta


