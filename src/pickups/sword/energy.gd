extends Node
signal value_changed(value,max_value)
signal empty()

export var value = 100.0 setget set_value
export var max_value = 100.0 setget set_max_value

func set_value(val):
	value = clamp(val,0,max_value)
	emit_signal("value_changed",value,max_value)
	if !value:
		emit_signal("empty")
	
func set_max_value(val):
	max_value = clamp(val,0,INF)
	set_value(clamp(value,0,max_value))
