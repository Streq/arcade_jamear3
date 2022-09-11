extends Node

signal trigger()

export var energy_path := NodePath("../energy")

onready var energy = get_node(energy_path)

export var time := 1.0

var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = time
	timer.one_shot = true
	timer.autostart = false
	if energy.value <= 0.0:
		timer.start()
	timer.connect("timeout",self,"_on_timeout")
	energy.connect("value_changed", self, "_on_energy_changed")

func _on_energy_changed(value, max_value):
	if value > 0.0:
		timer.stop()
	elif timer.is_stopped():
		timer.start()


func _on_timeout():
	emit_signal("trigger")
	energy.disconnect("value_changed", self, "_on_energy_changed")

