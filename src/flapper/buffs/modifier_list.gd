extends Node
class_name ModifierNode

func apply(on):
	for child in get_children():
		on = child.apply(on)
	return on
