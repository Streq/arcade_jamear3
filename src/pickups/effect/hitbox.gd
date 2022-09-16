extends Area2D

export var knockback := 200.0

func apply_knockback(on):
	on.velocity += get_knockback(on)
	
func get_knockback(target):
	return owner.velocity.normalized()*knockback
	
func can_hit(area):
	return true


func register_hit(area):
	pass
