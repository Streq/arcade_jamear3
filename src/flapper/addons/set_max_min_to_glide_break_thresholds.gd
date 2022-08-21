extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var p = get_parent()
	p.min_power = 0
	p.max_power = 400.0
	
#	p.min_power = owner.glide_break_recovery_threshold
#	p.max_power = owner.glide_break_threshold+100.0
