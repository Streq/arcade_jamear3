extends Node

export var first_focus : NodePath

var focused: Control = null
var ready = false
func _ready():
	if first_focus:
		focused = get_node(first_focus)
	focus()
	ready = true
	
	
func _on_focus_changed(node):
	focused = node

func focus():
	get_viewport().connect("gui_focus_changed", self, "_on_focus_changed")
	
	if is_instance_valid(focused):
		focused.grab_focus()
func _enter_tree():
	if ready:
		focus()

func _exit_tree():
	get_viewport().disconnect("gui_focus_changed", self, "_on_focus_changed")
	
