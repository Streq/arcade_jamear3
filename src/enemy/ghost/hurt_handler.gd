extends Node
func _on_hit(by:Area2D):
	if "velocity" in by.owner:
		owner.velocity = by.owner.velocity*1.5
	
