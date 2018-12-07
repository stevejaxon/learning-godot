extends MarginContainer

onready var number_label = $Bars/LifeBar/Count/Background/Number
onready var bar = $Bars/LifeBar/TextureProgress
onready var tween = $Tween
onready var animated_health = 0

func _ready():
	var player_max_health = $"../Characters/Player".max_health
	bar.max_value = player_max_health
	update_health(player_max_health)
	
func _process(delta):
	var round_value = round(animated_health)
	number_label.text = str(round_value)
	bar.value = round_value
	
func _on_Player_health_changed(player_health):
	update_health(player_health)
	
func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)