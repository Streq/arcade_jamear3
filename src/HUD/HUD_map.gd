extends CanvasLayer

#each map_layer is a tilemap
export (Array, NodePath) var map_layers
export var minimap_tiles : PackedScene

onready var pivot = $"%pivot"


# Called when the node enters the scene tree for the first time.
func _ready():
	for map_layer in map_layers:
		var map = get_node(map_layer)
		var minimap = minimap_tiles.instance()
		minimap.map = map
		pivot.add_child(minimap)
