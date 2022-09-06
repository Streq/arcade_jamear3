extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var minimap = Group.get_one("minimap")
	if minimap:
		minimap.set_to(null)
	
