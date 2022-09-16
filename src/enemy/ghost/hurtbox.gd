extends Area2D

signal hit(by)


func _on_hurtbox_area_entered(area):
	if area.can_hit(self):
		area.register_hit(self)
		emit_signal("hit", area)
