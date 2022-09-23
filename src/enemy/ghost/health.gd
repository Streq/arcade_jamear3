extends Node

signal dead(by)
export var value = 3.0

func _on_hit(by:Area2D):
	return
#	value -= by.get_damage(owner)
#	if value <= 0:
#		owner.queue_free()
#		emit_signal("dead",by)


func _on_take_damage(damage) -> void:
	value -= damage
	if value <= 0.0:
		owner.queue_free()
		emit_signal("dead",damage)

