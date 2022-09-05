extends Node
export var difficulty : NodePath
export var prop := ""
export var min_value := 0.0
export var max_value := 0.0
export var min_difficulty := 0.0
export var max_difficulty := 0.0

func _ready():
	var diff = get_node(difficulty)
	diff.connect("value_changed", self, "trigger",[],CONNECT_DEFERRED)
	trigger(diff.value)
func trigger(value):
	var mapped = range_lerp(
			value,
			min_difficulty,
			max_difficulty,
			min_value,
			max_value
		)
	var val = clamp(mapped, min_value, max_value)

	get_parent().set_indexed(prop, val)
	pass
