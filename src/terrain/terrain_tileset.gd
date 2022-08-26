tool
extends TileSet

const BLOCKS = 0
const SQUARE = 2
const SLOPE = 4
const SPACE = 5

var binds = {
	SQUARE : [SLOPE],
	SLOPE : [SQUARE],
	BLOCKS : [],
	SPACE : []
}

func _is_tile_bound(drawn_id, neighbor_id):
	return drawn_id in binds and neighbor_id in binds[drawn_id]
#	print(drawn_id,", ", neighbor_id)
#	print(drawn_id in binds)
#	print(neighbor_id in binds[drawn_id])
#	return neighbor_id != -1
