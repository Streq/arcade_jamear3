extends Node

export var point_source_path : NodePath

onready var point_source = get_node(point_source_path)
onready var spawn_source = $spawn_source
export var DEVICE : PackedScene

func spawn():
	var SPAWN :PackedScene = spawn_source.get_spawn()
	spawn_given(SPAWN)

func spawn_given(SPAWN):
	var spawn = SPAWN.instance()
	var point : Vector2 = point_source.get_random_point()
	var device = DEVICE.instance()
	device.add_child(spawn)
	get_parent().add_child(device)
	device.global_position = point

func _unhandled_key_input(event : InputEventKey):
	if OS.is_debug_build() and event.is_pressed():
		var i = event.scancode - KEY_1
		if i >= 0 and i <= 8 and i < spawn_source.get_child_count():
			spawn_given(spawn_source.get_child(i).scene)
	
