extends Node

var total_weight

func refresh():
	total_weight = 0
	for spawn in get_children():
		total_weight += spawn.weight
	
func _ready():
	refresh()
	connect("child_entered_tree",self,"_on_child_entered")
	connect("child_exiting_tree",self,"_on_child_exiting")

func _on_child_entered(child):
	refresh()
func _on_child_exiting(child):
	refresh()
func get_spawn():
	var r = rand_range(0,total_weight)
	print(r)
	for spawn in get_children():
		if spawn.weight > r:
			return spawn.scene
		r -= spawn.weight
	
