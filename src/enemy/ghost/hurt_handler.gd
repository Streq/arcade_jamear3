extends Node
func _on_hit(by:Area2D):
#	if "velocity" in by.owner:
#		owner.velocity = by.owner.velocity*2.0
#	by.apply_knockback(owner)
	pass

func _on_take_knockback(knockback):
	owner.velocity += knockback
