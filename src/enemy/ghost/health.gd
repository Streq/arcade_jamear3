extends Node

signal dead
export var value = 3

func _on_hit(by:Area2D):
	value -= 1
	if value <= 0:
		owner.queue_free()
		emit_signal("dead")
