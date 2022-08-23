extends Node

onready var levels = get_children()
var current_level = -1

func get_next_level():
	return levels[posmod(current_level+1,levels.size())]

func next_level():
	current_level = posmod(current_level+1,levels.size())
	load_level()

func prev_level():
	current_level = posmod(current_level-1,levels.size())
	load_level()
	
func curr_level():
	load_level()

func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			next_level()
		if event.is_action_pressed("prev_level"):
			prev_level()
		if event.is_action_pressed("curr_level"):
			curr_level()

func load_level():
	get_tree().change_scene_to(levels[current_level].scene)
	Global.new_level()
