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


func _init():
	if !Engine.editor_hint:
#		var texture = ImageTexture.new()
#		var image = Image.new()
#		image.create(1000, 1000, false,Image.FORMAT_RGBA8)
#		image.fill(Color(0, 0, 0, 0))
#		texture.create_from_image(image)
		tile_set_texture(SPACE, null)
#		tile_set_region(SPACE, Rect2(0,0,1,1))
		pass
		


