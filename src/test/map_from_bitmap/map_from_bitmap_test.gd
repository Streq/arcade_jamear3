extends Node2D
tool

export var bitmap : Texture
onready var tile_map: TileMap = $TileMap
export var draw_map : bool setget draw_map
export var tile := 0
export var empty_tile := 5
export var threshold := 0.5
export var pixel_scale := Vector2.ONE

func draw_map(val := false):
	tile_map.set("tile_data", PoolIntArray())
	var img = bitmap.get_data()
	
	var rect = pixel_scale.floor()
				
	img.lock()
	for y in img.get_height()*3:
		for x in img.get_width()*3:
			var pixel = img.get_pixel(x%img.get_width(),y%img.get_height())
			
			if pixel.r<threshold:
				for i in rect.x:
					for j in rect.y:
						tile_map.set_cell(x*rect.x+i-img.get_width(),y*rect.y+j-img.get_height(),tile)
			else:
				for i in rect.x:
					for j in rect.y:
						tile_map.set_cell(x*rect.x+i-img.get_width(),y*rect.y+j-img.get_height(),empty_tile)
	var bounds = img.get_size()*rect
#	for y in bounds.y+2:
#		tile_map.set_cell(-1,y-1,tile)
#		tile_map.set_cell(bounds.x,y-1,tile)
#	for x in bounds.x+2:
#		tile_map.set_cell(x-1,-1,tile)
#		tile_map.set_cell(x-1,bounds.y,tile)
	img.unlock()
	tile_map.update_bitmask_region()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	draw_map()
	pass
