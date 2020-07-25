extends Control

func _ready():
	for button in get_tree().get_nodes_in_group("menu_buttons"):
		button.connect("scene_transition", self, "_transition_scene")
		button.connect("scene_transition", button, "_prevent_interaction")

func _transition_scene(next_scene: PackedScene) -> void:
	$SceneTransition.transition_out()
	yield($SceneTransition, "transition_finished")
	get_tree().change_scene_to(next_scene)
