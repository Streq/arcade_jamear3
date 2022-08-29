extends Node2D

export var SPAWNED : PackedScene

var spawned_instances = []
onready var timer = $Timer



export var max_spawns := 1

func spawn():
	var enabled_points = []
	for point in get_children():
		if "enabled" in point and point.enabled:
			enabled_points.append(point)
	
	if !enabled_points.size():
		return
	
	var i = randi()%enabled_points.size()
	var point = enabled_points[i]
	
	var instance = SPAWNED.instance()
	get_tree().current_scene.add_child(instance)
	instance.global_position = point.global_position
	spawned_instances.append(instance)
	
	instance.connect("tree_exiting",self,"_on_instance_gone",[instance])
	print("spawned")
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
