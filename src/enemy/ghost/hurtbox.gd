extends Area2D

signal hit(by)
signal take_knockback(knockback)
signal take_damage(damage)

func _on_area_entered(area):
	if area.can_hit(self):
		area.register_hit(self)
		emit_signal("hit", area)

func take_knockback(knockback):
	emit_signal("take_knockback", knockback)
func take_damage(damage):
	emit_signal("take_damage", damage)
