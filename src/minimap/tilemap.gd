extends TileMap
var map
# Called when the node enters the scene tree for the first time.
func _ready():
#	if !map.is_inside_tree():
#		yield(map, "ready")
	scale = map.cell_size/8.0
	self.set("tile_data", map.get("tile_data"))
#	self.scale *=0.5
