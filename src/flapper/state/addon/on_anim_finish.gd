extends Node
signal trigger

func _ready():
	var state = get_parent()
	state.connect("entered", self, "_on_entered")
	state.connect("exited", self, "_on_exited")
	
	for child in get_children():
		child.root = state
		connect("trigger",child,"trigger")
	
func _on_entered():
	owner.state_animation.connect("animation_finished",self,"_on_animation_finished")
func _on_exited():
	owner.state_animation.disconnect("animation_finished",self,"_on_animation_finished")

func _on_animation_finished(name):
	emit_signal("trigger")
