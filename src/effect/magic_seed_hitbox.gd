extends Area2D


export var knockback := 2.0

func apply_knockback(on):
	on.velocity += get_knockback(on)
func get_knockback(target):
	return get_parent().velocity*knockback
func register_hit(area):
	pass
func can_hit(area):
	return true
