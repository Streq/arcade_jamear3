extends Node

signal duplicated(clone)
func _ready():
	owner.wearer.connect("duplicated", self, "_on_duplicated")
	
func _on_duplicated(clone):
	emit_signal("duplicated",clone)
