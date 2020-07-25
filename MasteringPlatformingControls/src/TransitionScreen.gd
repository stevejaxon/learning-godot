tool
extends ColorRect

signal transition_finished

export var transition_shader_mask: Texture setget set_transition_shader_mask

func _ready():
	material.set_shader_param("color", color)

func transition_out() -> void:
	$AnimationPlayer.play("transition_out")
	yield($AnimationPlayer,"animation_finished")
	emit_signal("transition_finished")

func set_transition_shader_mask(value: Texture) -> void:
	transition_shader_mask = value
	material.set_shader_param("mask", value)

func _get_configuration_warning():
	if transition_shader_mask == null:
		return 'Transition shader mask not set'
	return ''

