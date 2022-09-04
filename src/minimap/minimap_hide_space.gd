tool
extends TileSet

const SPACE = 5

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
		


