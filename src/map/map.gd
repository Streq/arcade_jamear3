extends Node
signal area_completed


func area_completed():
	emit_signal("area_completed")
