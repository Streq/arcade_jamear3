extends Node
tool
export var delta = 0.0

export var trigger := false setget trigger

func trigger(val):
	var np = get_parent().navpoly
	
	for i in np.get_outline_count():
		var outline = np.get_outline(0)
		if GeometryUtils.is_hole(outline):
			outline = Geometry.offset_polygon_2d(outline,-delta,0)[0]

		else:
			outline = Geometry.offset_polygon_2d(outline,delta,0)[0]
		np.remove_outline(0)
		np.add_outline(outline)
	
	np.make_polygons_from_outlines()
	
	
	pass
