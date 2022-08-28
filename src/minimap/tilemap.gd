extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().current_scene,"ready")
	var map : TileMap = Group.get_one("map")
	self.set("tile_data", map.get("tile_data"))
#	self.scale *=0.5
