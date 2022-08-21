extends Node

signal value_changed(current_value, max_value)

export var max_value = 100.0 setget set_max_value
export var value = 100.0 setget set_value
export var flap_cost = 5.0
export var regen = 1.0

var flapper
var ready = false
func _ready():
	flapper = get_parent()
	yield(flapper, "ready")
	flapper.connect("flapped", self, "_on_flapped")
	flapper.addons["energy"] = self
	ready = true
	set_max_value(max_value)
	set_value(value)
func _on_flapped():
	set_value(value-flap_cost)

func set_value(val):
	value = val
	if ready:
		flapper.can_flap = val > flap_cost
		emit_signal("value_changed", value, max_value)

func set_max_value(val):
	max_value = val
	if ready:
		emit_signal("value_changed", value, max_value)

func add_value(val):
	set_value(value+val)

func _physics_process(delta):
	set_value(clamp(value+regen*delta, 0, max_value))

