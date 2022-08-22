extends Polygon2D

#returns random point in global_coords
func get_random_point() -> Vector2:
	var rand_point = GeometryUtils.random_point_in_polygon(polygon)
	return global_transform.xform(rand_point)
