extends Area2D

export var knockback := 200.0

func apply_knockback(on):
	on.velocity += owner.velocity.normalized()*knockback
	
func get_knockback():
	return owner.velocity.normalized()*knockback
	
