extends Node

export var animation := ""

func _ready():
	var state = get_parent()
	state.connect("entered", self, "_on_entered")
	
func _on_entered():
	owner.state_animation.play(animation)
