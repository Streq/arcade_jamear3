extends Area2D


export var knockback := 2.0

func apply_knockback(on):
	on.velocity += get_parent().velocity*knockback
func get_knockback(point := Vector2()):
	return get_parent().velocity*knockback
