extends Node
signal value_changed(new_value)

export var value := 0.0 setget set_value

func set_value(val):
	value = val
	emit_signal("value_changed", value)

