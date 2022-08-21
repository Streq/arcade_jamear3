extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().current_scene,"ready")
	var map : TileMap = get_tree().get_nodes_in_group("map")[0]
	self.set("tile_data", map.get("tile_data"))
	self.scale *=0.5
