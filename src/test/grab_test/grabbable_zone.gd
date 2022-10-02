extends Area2D
export var grabbed := false setget set_grabbed
signal grabbed(by)
signal dropped(by)
func set_grabbed(val):
	grabbed = val


func _on_grab(by):
	get_parent().set_physics_process(false)
	emit_signal("grabbed",by)
	pass

func _on_drop(by):
	grabbed = false
	get_parent().set_physics_process(true)
	emit_signal("dropped",by)
	pass
	
