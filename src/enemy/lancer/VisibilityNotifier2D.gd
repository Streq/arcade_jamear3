extends VisibilityNotifier2D

func _physics_process(delta: float) -> void:
	if owner.disappear_on_screen_exit and !is_on_screen():
#		owner.queue_free()
		owner.disable()
