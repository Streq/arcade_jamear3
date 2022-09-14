extends Node
class_name ModifierMap


var map = {}

enum Priority {
	FIRST = 0,
	SOON = 1,
	NORMAL = 2,
	LATE = 3,
	LAST = 4
}

func _ready():
	for child in get_children():
		map[child.name] = child

func get_modifiers(property):
	return map[property]

func add_modifier(property: String, modifier: Node, priority: int = 2):
	map[property].get_child(priority).add(modifier)
