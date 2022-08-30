extends Node

export var SPAWN : PackedScene
onready var timer = $Timer
var spawn = null

func spawn():
	if is_inside_tree():
		var point = get_parent().get_random_point()
		spawn = SPAWN.instance()
		spawn.connect("tree_exited", self, "_seed_taken")
		yield(get_tree(),"idle_frame")
		get_tree().current_scene.add_child(spawn)
		spawn.global_position = point
		spawn.connect("tree_exited", self, "_on_seed_taken")

func _on_seed_taken():
	timer.start()


func _on_Timer_timeout():
	spawn()
