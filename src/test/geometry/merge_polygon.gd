extends Node2D
tool 
signal A_pressed

export var block_size := 32


onready var tile_map = $TileMap

onready var merged = $NavigationPolygonInstance
onready var islands_label = $islands
onready var holes_label = $holes

export var update : bool setget set_update
func set_update(val):
	_generate_polygon()

func _input(event):
	if event.is_action_pressed("A"):
		emit_signal("A_pressed")

func _ready():
	if !Engine.editor_hint:
		_generate_polygon()
		tile_map.queue_free()
		

func _generate_polygon_block(x0,y0,w,h):
	var rect = tile_map.get_used_rect()
	var tiles = tile_map.get_used_cells()
	var tile_size = tile_map.cell_size
	var navpoly = merged.navpoly
	var islands = []
	var holes = []
	# por cada tile
	
	for y in range(y0,y0+h):
		for x in range(x0,x0+w):
			var tilemap_coord = Vector2(x,y)
			
			
#			update_polygon(navpoly,islands,holes)
			var tile_id = tile_map.get_cellv(tilemap_coord)
			if tile_id == TileMap.INVALID_CELL:
				continue
			var nav : NavigationPolygon = tile_map.tile_set.tile_get_navigation_polygon(tile_id)
			var offset : Vector2 = tile_map.tile_set.tile_get_navigation_polygon_offset(tile_id)
			if !nav:
				continue
			var world_coord = tile_size*tilemap_coord+offset
			var outlines = nav.outlines
			# por cada outline en el tile
			for outline in outlines:
				var transformed_outline = apply_tilemap_xform(outline, world_coord)
				var taken = false
				# por cada isla
				if !islands.size():
					islands.append(transformed_outline)
					break
				for i in islands.size():
					if taken:
						break
					#tratar de mergear
					var merged_polygons = attempt_poly_merge(islands[i], transformed_outline)
					#si no colisionan seguir
					if !merged_polygons:
						continue
					for merged_polygon in merged_polygons:
						taken = true
						if !is_hole(merged_polygon):
							# si el resultado colisiona con otras islas, mergear
							islands[i] = merged_polygon
							var result = merge_polys(islands)
							islands = result.islands
							holes.append_array(result.holes)
						else:#if a hole
							holes.append(merged_polygon)
				if !taken:
					islands.append(transformed_outline)
#		update_polygon(navpoly,islands,holes)
	return {"islands":islands,"holes":holes}

func _generate_polygon():
#	var navpoly = merged.navpoly
#	var ret = _generate_polygon_block(0,0,32,32)
#	update_polygon(navpoly,ret.islands,ret.holes)
	var rect = tile_map.get_used_rect()
	var islands = []
	var holes = []
	var navpoly = merged.navpoly
	for j in range(rect.position.y, rect.end.y, block_size):
		for i in range(rect.position.x, rect.end.x, block_size):
			var merged = _generate_polygon_block(i, j, block_size, block_size)
			islands.append_array(merged.islands)
			holes.append_array(merged.holes)
	var merge = merge_polys(islands)
	islands = merge.islands
#	holes.append_array(merge.holes)
	update_polygon(navpoly,islands,holes)
	return



#WORKING
#	var used_cells = tile_map.get_used_cells()
#	var rect = tile_map.get_used_rect()
#	var tile_size = tile_map.cell_size
#	var navpoly = merged.navpoly
#	var islands = []
#	var holes = []
#	# por cada tile
#	for tilemap_coord in used_cells:
#		update_polygon(navpoly,islands,holes)
#		var tile_id = tile_map.get_cellv(tilemap_coord)
#
#		var nav : NavigationPolygon = tile_map.tile_set.tile_get_navigation_polygon(tile_id)
#		var offset : Vector2 = tile_map.tile_set.tile_get_navigation_polygon_offset(tile_id)
#		if !nav:
#			continue
#		var world_coord = tile_size*tilemap_coord+offset
#		var outlines = nav.outlines
#		# por cada outline en el tile
#		for outline in outlines:
#			var transformed_outline = apply_tilemap_xform(outline, world_coord)
#			var taken = false
#			# por cada isla
#			if !islands.size():
#				islands.append(transformed_outline)
#				break
#			for i in islands.size():
#				if taken:
#					break
#				#tratar de mergear
#				var merged_polygons = attempt_poly_merge(islands[i], transformed_outline)
#				#si no colisionan seguir
#				if !merged_polygons:
#					continue
#				for merged_polygon in merged_polygons:
#					taken = true
#					if !is_hole(merged_polygon):
#						# si el resultado colisiona con otras islas, mergear
#						islands[i] = merged_polygon
#						var result = merge_polys(islands)
#						islands = result.islands
#						holes.append_array(result.holes)
#					else:#if a hole
#						holes.append(merged_polygon)
#			if !taken:
#				islands.append(transformed_outline)
#	update_polygon(navpoly,islands,holes)

func update_polygon(navpoly,islands,holes):
	navpoly.clear_outlines()
	for island in islands:
		navpoly.add_outline(island)
	for hole in holes:
		navpoly.add_outline(hole)
	navpoly.make_polygons_from_outlines()
	islands_label.text = "islands: %d" % islands.size()
	holes_label.text = "holes: %d" % holes.size()

func merge_polys(polys):
	var result = {islands=polys,holes=[]}
	var i = 0
	var j = 0
	
	while i != polys.size():
		var a = polys[i]
		j = i+1
		while j != polys.size():
			var b = polys[j]
			var merges = attempt_poly_merge(a,b)
			if merges:
				var islands = []
				var holes = []
				for merge in merges:
					if is_hole(merge):
						holes.append(merge)
					else: 
						islands.append(merge)
				if islands.size() == 1:
					polys[i] = islands[0]
					polys.remove(j)
					j -= 1
				result.holes.append_array(holes)
			j += 1
		i += 1
	return result

func is_hole(polygon):
	return Geometry.is_polygon_clockwise(polygon)

func attempt_poly_merge(a,b):
	var merged_polygons = Geometry.merge_polygons_2d(a, b)
	var first = merged_polygons[0]
	#if at least one of the results is either of the input ones 
	#and there's two results
	#then we know the merge failed
	if merged_polygons.size()==2 and !is_hole(merged_polygons[0]) and !is_hole(merged_polygons[1]):
		return []
	return merged_polygons
	
func apply_tilemap_xform(points: PoolVector2Array, woorld_coord: Vector2):
	var xformed = PoolVector2Array()
	for point in points:
		xformed.append(tile_map.transform.xform(point+woorld_coord))
	return xformed

