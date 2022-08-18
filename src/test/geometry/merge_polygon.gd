extends Node2D

onready var tile_map = $TileMap

onready var merged = $NavigationPolygonInstance

func _ready():
	
	var cells = tile_map.get_used_cells()
	var polys = []
	
	for cell in cells:
		var i = tile_map.get_cellv(cell)
		var nav = tile_map.tile_set.tile_get_navigation_polygon(i)
		print(cell)
		print(nav.polygons)
	var navpoly = merged.navpoly
	for poly in polys:
		navpoly.add_outline(poly)
	navpoly.make_polygons_from_outlines()
	print(polys.size())
	
	
