extends Node

signal trigger

func trigger(_a,_b):
	emit_signal("trigger")
