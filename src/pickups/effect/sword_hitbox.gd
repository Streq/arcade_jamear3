extends Area2D

export var knockback := 200.0

func apply_knockback(on):
	on.velocity += Vector2.DOWN.rotated(global_rotation)*knockback
	
func get_knockback():
	return Vector2.DOWN.rotated(global_rotation)*knockback
	
