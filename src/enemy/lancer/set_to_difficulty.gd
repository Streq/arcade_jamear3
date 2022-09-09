extends Node
export var difficulty : NodePath
export var prop := ""
export var min_value := 0.0
export var max_value := 0.0
export var min_difficulty := 0.0
export var max_difficulty := 0.0
export var enabled: bool = true setget set_enabled

func set_enabled(val):
	if !ready:
		return
	if enabled != val:
		enabled = val
		if enabled:
			diff.connect("value_changed", self, "trigger",[],CONNECT_DEFERRED)
			trigger(diff.value)
		else:
			diff.disconnect("value_changed", self, "trigger",[],CONNECT_DEFERRED)
	pass
	
	
var ready = false
var diff
func _ready():
	diff = get_node(difficulty)
	if enabled:
		diff.connect("value_changed", self, "trigger",[],CONNECT_DEFERRED)
		trigger(diff.value)
	ready = true

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
