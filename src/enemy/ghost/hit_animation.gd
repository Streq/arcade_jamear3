extends AnimationPlayer


func _on_hit(area):
	play("hit")
func _on_dead(by):
	play("RESET")
