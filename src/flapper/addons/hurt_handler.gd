extends Node
signal killed_by_hit()
func _on_hit(by:Area2D):
	emit_signal("killed_by_hit")
	owner.die()
