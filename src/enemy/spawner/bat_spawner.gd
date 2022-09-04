extends Node2D

export var SPAWNED : PackedScene
export var DEATH : PackedScene

var spawned_instances = []
onready var timer = $Timer

export var difficulty = 0.0

export var max_spawns := 1

func spawn():
	var point = get_random_point()
	
	var instance = SPAWNED.instance()
	get_parent().add_child(instance)
	instance.global_position = point.global_position
	spawned_instances.append(instance)
	
	instance.connect("tree_exiting",self,"_on_instance_gone",[instance])
#	print("spawned")
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


func get_random_point():
	var enabled_points = []
	for point in get_children():
		if "enabled" in point and point.enabled:
			enabled_points.append(point)
	
	if !enabled_points.size():
		return self
	
	var i = randi()%enabled_points.size()
	var point = enabled_points[i]
	return point

func spawn_death():
	var point = get_random_point()
	var instance = DEATH.instance()
	get_parent().add_child(instance)
	instance.global_position = point.global_position
	


func _on_DeathTimer_timeout():
	spawn_death()
