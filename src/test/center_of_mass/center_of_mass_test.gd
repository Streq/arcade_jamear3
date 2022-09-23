extends Node2D

onready var fast_glider: KinematicBody2D = $fast_glider
onready var palette: Node = $palette
onready var palette_entry = {"priority":1, "palette":palette}
export var WING_GUN : PackedScene
func _ready():
#	remove_child(palette)
#	fast_glider.palette_manager.add_palette(palette_entry)
	
	for i in 1:
		var addon0 = WING_GUN.instance()
		addon0.pre_ready(fast_glider)
		fast_glider.pivot.call_deferred("add_child",addon0)
		addon0.set_deferred("owner",fast_glider)
	
	
#	print(Group.get_all("bullet").size())
	pass
