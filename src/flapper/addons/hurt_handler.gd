extends Node
signal killed_by_hit()
func _on_hit(by:Area2D):
	if "velocity" in by.owner:
		owner.velocity = (owner.velocity + by.owner.velocity)/2.0
	emit_signal("killed_by_hit")
	owner.die()
