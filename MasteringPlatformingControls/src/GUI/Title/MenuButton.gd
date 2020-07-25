tool
extends Button

signal scene_transition

export var target_scene : PackedScene

func _ready():
	add_to_group("menu_buttons")

func _get_configuration_warning():
	if not target_scene:
		return 'Target Scene not set'
	if not text:
		return 'Button text not set'
	return ''


func _on_Button_button_up():
	emit_signal("scene_transition", target_scene)
