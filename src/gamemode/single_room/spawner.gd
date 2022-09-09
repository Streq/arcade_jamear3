extends Node2D

export var SPAWNED : PackedScene

export var transform_source_path := NodePath("transform_source")
onready var transform_source = get_node(transform_source_path)

var spawned_instances = []
onready var timer = $Timer


export var max_spawns := 1

func spawn():
	var instance = SPAWNED.instance()
	get_parent().add_child(instance)
	var some_transform : Transform2D = transform_source.get_transform()
	instance.global_position = some_transform.get_origin()
	spawned_instances.append(instance)
	
	instance.connect("tree_exiting",self,"_on_instance_gone",[instance])
	if max_spawns > spawned_instances.size():
		_on_free_slot()
	
func _on_free_slot():
	if timer.is_stopped():
		timer.start()


func _on_instance_gone(who):
	spawned_instances.remove(spawned_instances.find(who))
	if spawned_instances.size()<max_spawns:
		_on_free_slot()

func _on_Timer_timeout():
	spawn()
