extends Node2D

onready var tile_map = $TileMap

onready var merged = $NavigationPolygonInstance

func _ready():
	
	var used_cells = tile_map.get_used_cells()
	var current_polygon = PoolVector2Array()
	var tile_size = tile_map.cell_size
	
	var navpoly = merged.navpoly
	var islands = []
	var holes = []
	for tilemap_coord in used_cells:
		var tile_id = tile_map.get_cellv(tilemap_coord)
		var nav : NavigationPolygon = tile_map.tile_set.tile_get_navigation_polygon(tile_id)
		var world_coord = tile_size*tilemap_coord
		var outlines = nav.outlines
		for outline in outlines:
			var transformed_polygon = PoolVector2Array()
			for point in outline:
				transformed_polygon.append(point+world_coord)
			var merged_polygons = Geometry.merge_polygons_2d(current_polygon, transformed_polygon)
			var taken = false
			for merged_polygon in merged_polygons:
				if !Geometry.is_polygon_clockwise(merged_polygon):
					if !taken:
						current_polygon = merged_polygon
						taken = true
					else:
						islands.append(merged_polygon)
				else:
					holes.append(merged_polygon)

#			print(merged_polygons.size())
#		print(cell)
#		print(nav.polygons)
#
	
#	for poly in polys:
	for hole in holes:
		navpoly.add_outline(hole)
	navpoly.add_outline(current_polygon)
	
	navpoly.make_polygons_from_outlines()
	
	
#	print(polys.size())
	
	
