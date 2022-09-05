extends Node
signal set_to(player)
#each map_layer is a tilemap
export var minimap_tiles : PackedScene

onready var pivot = $"%pivot"
var minimaps = []

func set_to(player):
	reset()
	emit_signal("set_to",player)

# Called when the node enters the scene tree for the first time.
func reset():
	for minimap in minimaps:
		minimap.queue_free()
	minimaps = []
	for map in Group.get_all("map"):
		var minimap = minimap_tiles.instance()
		minimaps.append(minimap)
		minimap.map = map
		pivot.add_child(minimap)
