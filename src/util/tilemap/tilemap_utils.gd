class_name TilemapUtils

static func merge_navigation_polygons_into_one(tilemap:TileMap, block_size:=64) -> Dictionary:
	var islands = []
	var holes = []
	
	
	
	return {islands=null, holes=null}


static func _generate_polygon_block(tilemap:TileMap,x0,y0,w,h):
	var rect = tilemap.get_used_rect()
	var tiles = tilemap.get_used_cells()
	var tile_size = tilemap.cell_size
	var islands = []
	var holes = []
	# por cada tile
	
	for y in range(y0,y0+h):
		for x in range(x0,x0+w):
			var tilemap_coord = Vector2(x,y)
			
			
#			update_polygon(navpoly,islands,holes)
			var tile_id = tilemap.get_cellv(tilemap_coord)
			if tile_id == TileMap.INVALID_CELL:
				continue
			var nav : NavigationPolygon = tilemap.tile_set.tile_get_navigation_polygon(tile_id)
			var offset : Vector2 = tilemap.tile_set.tile_get_navigation_polygon_offset(tile_id)
			if !nav:
				continue
			var world_coord = tile_size*tilemap_coord+offset
			var outlines = nav.outlines
			# por cada outline en el tile
			for outline in outlines:
				var transform = Transform2D().translated(world_coord)*tilemap.transform
				var transformed_outline = transform.xform(outline)
				var taken = false
				# por cada isla
				if !islands.size():
					islands.append(transformed_outline)
					break
				for i in islands.size():
					if taken:
						break
					#tratar de mergear
					var merged_polygons = GeometryUtils.attempt_poly_merge(islands[i], transformed_outline)
					#si no colisionan seguir
					if !merged_polygons:
						continue
					for merged_polygon in merged_polygons:
						taken = true
						if !GeometryUtils.is_hole(merged_polygon):
							# si el resultado colisiona con otras islas, mergear
							islands[i] = merged_polygon
							var result = GeometryUtils.merge_polys(islands)
							islands = result.islands
							holes.append_array(result.holes)
						else:#if a hole
							holes.append(merged_polygon)
				if !taken:
					islands.append(transformed_outline)
#		update_polygon(navpoly,islands,holes)
	return {"islands":islands,"holes":holes}



