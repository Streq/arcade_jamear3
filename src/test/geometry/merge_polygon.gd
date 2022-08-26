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
		_generate_polygon()
		tile_map.queue_free()
		

func _generate_polygon():
	var time_start = Time.get_ticks_usec()

	var navpoly = merged.navpoly
	var merge = TilemapUtils.merge_navigation_polygons_into_one(tile_map)
	
	update_polygon(navpoly, merge.islands, merge.holes)
	var total_time = Time.get_ticks_usec()-time_start
	print("took %d usecs" % total_time)
	
	return


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

