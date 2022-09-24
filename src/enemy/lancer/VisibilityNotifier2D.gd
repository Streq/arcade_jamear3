extends VisibilityNotifier2D


func _delete_if_offscreen():
	if owner.disappear_on_screen_exit and !is_on_screen():
		owner.queue_free()
