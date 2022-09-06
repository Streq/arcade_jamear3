extends Node

signal next_level()
signal loaded_level()
signal level_finished()
signal finished()

onready var levels = get_children()
var current_level = -1

var instanced_level = null

export var root : NodePath

func get_next_level():
	return levels[posmod(current_level+1,levels.size())]

func next_level():
	emit_signal("level_finished")
	if current_level+1 == levels.size():
		emit_signal("finished")
	else:
		current_level = posmod(current_level+1,levels.size())
		yield(load_level(),"completed")
		emit_signal("next_level")
	
func prev_level():
	current_level = posmod(current_level-1,levels.size())
	load_level()
	
func curr_level():
	load_level()



func load_level():
	AudioServer.set_bus_mute(0,true)
	LoadingHud.visible = true
	Music.play_music_no_crossfade("")
	
	for i in 1:
		yield(get_tree(),"idle_frame")
	if is_instance_valid(instanced_level):
		instanced_level.get_parent().remove_child(instanced_level)
		instanced_level.free()
	instanced_level = levels[current_level].scene.instance()
	get_node(root).add_child(instanced_level)
	instanced_level.connect("area_completed",self,"next_level")
#	Global.new_level()
	emit_signal("loaded_level")
	LoadingHud.visible = false
	
	for i in 1:
		yield(get_tree(),"idle_frame")

	AudioServer.set_bus_mute(0,false)
	
