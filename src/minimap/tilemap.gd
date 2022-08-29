extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().current_scene,"ready")
	var map : TileMap = Group.get_one("map")
	scale = map.cell_size/8.0
	self.set("tile_data", map.get("tile_data"))
#	self.scale *=0.5
