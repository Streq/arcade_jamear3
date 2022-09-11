extends Node

signal trigger()


func trigger():
	emit_signal("trigger")
	
