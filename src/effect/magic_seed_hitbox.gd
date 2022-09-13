extends Area2D


export var knockback := 2.0

func apply_knockback(on):
	on.velocity += get_parent().velocity*knockback
