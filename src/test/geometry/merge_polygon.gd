extends Node2D
tool 
signal A_pressed

export var block_size := 32


onready var tile_map = $TileMap

onready var merged = $NavigationPolygonInstance
onready var islands_label = $islands
onready var holes_label = $holes

var polygon = {}


export var update : bool setget set_update
func set_update(val):
	_generate_polygon()

func _input(event):
	if event.is_action_pressed("A"):
		emit_signal("A_pressed")

func _ready():
	if !Engine.editor_hint:
#		_generate_polygon()
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
					var merged_polygons = GeometryUtils.attempt_poly_merge(islands[i], transformed_outline)
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
	var time_start = Time.get_ticks_usec()

	var navpoly = merged.navpoly
	var merge = TilemapUtils.merge_navigation_polygons_into_one(tile_map)
	
	update_polygon(navpoly, merge.islands, merge.holes)
	var total_time = Time.get_ticks_usec()-time_start
	print("took %d usecs" % total_time)
	
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
	OS.get_time()
	var result = {islands=polys,holes=[]}
	var i = 0
	var j = 0
	
	while i != polys.size():
		var a = polys[i]
		j = i+1
		while j != polys.size():
			var b = polys[j]
			var merges = GeometryUtils.attempt_poly_merge(a,b)
			if merges:
				var islands = []
				var holes = []
				for merge in merges:
					if is_hole(merge):
						holes.append(merge)
					else: 
						islands.append(merge)
				if islands.size() == 1:
					a = islands[0]
					polys.remove(j)
					j = i
				result.holes.append_array(holes)
#			print(polys.size())
			j += 1
		polys[i] = a
		i += 1
	return result

func is_hole(polygon):
	return Geometry.is_polygon_clockwise(polygon)


	
func apply_tilemap_xform(points: PoolVector2Array, woorld_coord: Vector2):
	var xformed = PoolVector2Array()
	for point in points:
		xformed.append(tile_map.transform.xform(point+woorld_coord))
	return xformed

