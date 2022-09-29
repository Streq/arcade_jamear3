extends Node2D
tool

onready var bitmap_node: Node = $BuggyViewportTextureExportWorkaround

export var n0 : NoiseTexture
export var n1 : NoiseTexture
export var n2 : NoiseTexture

onready var tile_map: TileMap = $TileMap
export var draw_map : bool setget draw_map
export var _seed : int setget set_seed
export var tile := 0
export var empty_tile := 5
export var threshold := 0.5
export var pixel_scale := Vector2.ONE
export var random_seed : bool setget random_seed


func set_seed(val):
	_seed = val
	n0.noise.seed = _seed
	n1.noise.seed = _seed
	n2.noise.seed = _seed
	if is_inside_tree():
		yield(get_tree().create_timer(0.25),"timeout")
		draw_map()
	pass




func _ready() -> void:
	if !Engine.editor_hint:
#		draw_map()
		pass	
func random_seed(val:=false):
	set_seed(randi())


func draw_map(val := false):
	tile_map.set("tile_data", PoolIntArray())
	var img = bitmap_node.vpt.get_data()
	
	var rect = pixel_scale.floor()
				
	img.lock()
	for y in img.get_height():
		for x in img.get_width():
			var pixel = img.get_pixel(x%img.get_width(),y%img.get_height())
			
			if pixel.r==1.0:
				for i in rect.x:
					for j in rect.y:
						tile_map.set_cell(x*rect.x+i,y*rect.y+j,tile)
			
			elif empty_tile != -1:
				for i in rect.x:
					for j in rect.y:
						tile_map.set_cell(x*rect.x+i,y*rect.y+j,empty_tile)
	var bounds = img.get_size()*rect
	for y in bounds.y+2:
		tile_map.set_cell(-1,y-1,tile)
		tile_map.set_cell(bounds.x,y-1,tile)
#	for x in bounds.x+2:
#		tile_map.set_cell(x-1,-1,tile)
#		tile_map.set_cell(x-1,bounds.y,tile)
#	img.unlock()
	tile_map.update_bitmask_region()

