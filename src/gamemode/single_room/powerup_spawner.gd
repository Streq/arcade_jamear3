extends Node

export var point_source_path : NodePath

onready var point_source = get_node(point_source_path)
onready var spawn_source = $spawn_source


func spawn():
	var SPAWN :PackedScene = spawn_source.get_spawn()
	var spawn = SPAWN.instance()
	var point : Vector2 = point_source.get_random_point()
	
	get_parent().add_child(spawn)
	spawn.global_position = point
