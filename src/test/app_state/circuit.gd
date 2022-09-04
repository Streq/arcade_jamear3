extends Node

signal next_level()
signal loaded_level()
onready var levels = get_children()
var current_level = -1

var instanced_level = null

export var root : NodePath

func get_next_level():
	return levels[posmod(current_level+1,levels.size())]

func next_level():
	current_level = posmod(current_level+1,levels.size())
	load_level()
	emit_signal("next_level")
	
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
	
