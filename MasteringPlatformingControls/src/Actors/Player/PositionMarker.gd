extends Control
class_name PositionMarker

enum INDICATOR {REGULAR, COYOTE, BUFFER}

var type: int = 0 setget set_type

func _on_DisplayTimer_timeout():
	queue_free()

func set_type(value: int):
	type = value
	match value:
		INDICATOR.COYOTE:
			set_modulate(Color(0.07, 0.95, 0, 1))
		INDICATOR.BUFFER:
			set_modulate(Color(0.95, 0, 0.8, 1))
		_:
			set_modulate(Color(1, 1, 1, 1))
