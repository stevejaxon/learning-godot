extends Control

func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
func _on_Button_pressed(scenes):
	yield($FadeIn.transition(), "completed")
	get_tree().change_scene(scenes)