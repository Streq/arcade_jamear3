extends Node2D


export var size := 1500
export var OBJECT : PackedScene

var bullets = []
var unused_bullets = []
func _ready() -> void:
	for i in size:
		var instance = OBJECT.instance()
		instance.index = i
		bullets.push_back(instance)
		call_deferred("add_child",instance)
		instance.call_deferred("disable")
		

func get_one():
	if unused_bullets.empty():
		return create_instance()
	var index = unused_bullets.pop_back()
	var bullet = bullets[index]
	bullet.enable()
	return bullet
	

func create_instance():
	var instance = OBJECT.instance()
	instance.index = size
	size += 1
	bullets.push_back(instance)
	call_deferred("add_child",instance)
	instance.call_deferred("enable")
	return instance
	
