extends Node

export var point_source_path : NodePath

onready var point_source = get_node(point_source_path)
onready var spawn_source = $spawn_source
export var DEVICE : PackedScene

func spawn():
	var SPAWN :PackedScene = spawn_source.get_spawn()
	var spawn = SPAWN.instance()
	var point : Vector2 = point_source.get_random_point()
	var device = DEVICE.instance()
	device.add_child(spawn)
	get_parent().add_child(device)
	device.global_position = point
