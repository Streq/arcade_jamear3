extends Node
class_name GeometryUtils

func get_random_point(triangulated_polygon : PoolVector2Array):
	pass

static func random_point_in_triangle(A:Vector2,B:Vector2,C:Vector2):
	var r1 = rand_range(0,1)
	var r2 = rand_range(0,1)
	if (r1 + r2 > 1):
		r1 = 1 - r1
		r2 = 1 - r2
	
	var a = 1 - r1 - r2
	var b = r1
	var c = r2

	return a*A + b*B + c*C
	

static func random_point_in_polygon(polygon: PoolVector2Array):
	var indexes = Geometry.triangulate_polygon(polygon)
	var triangles = PoolVector2Array()
	for i in indexes:
		triangles.append(polygon[i])
	return random_point_in_triangles(triangles)

static func random_point_in_triangles(triangles: PoolVector2Array):
	# if you don't weigh by area you get smaller triangles concentrating all them points!!!!!
	var triangle = random_triangle_weighted_by_area(triangles)
	
#	var triangle = random_triangle(triangles)
	return random_point_in_triangle(triangle[0], triangle[1], triangle[2])

static func random_triangle_weighted_by_area(triangles: PoolVector2Array, areas = null):
	if !areas:
		areas = get_triangle_areas(triangles)
	var sum = areas[-1]
	var r = rand_range(0, sum)
	var i = 0
	while i < areas.size()-1:
		r -= areas[i]
		if r <= 0:
			break
		i += 1
	i *= 3
	return PoolVector2Array([triangles[i],triangles[i+1],triangles[i+2]])

static func random_triangle(triangles: PoolVector2Array):
	var i = randi()%triangles.size()/3*3
	return PoolVector2Array([triangles[i],triangles[i+1],triangles[i+2]])

#assumes triangles to be an array of triangles represented by triplets of points
#returns an array of areas, last element being the sum of all areas
static func get_triangle_areas(triangles:PoolVector2Array):
	var areas = PoolRealArray()
	var sum = 0.0
	for i in range(0, triangles.size(), 3):
		var area = get_triangle_area(triangles[i], triangles[i+1], triangles[i+2])
		sum += area
		areas.append(area)
	areas.append(sum)
	return areas

static func get_triangle_area(A,B,C):
	return abs(A.x*(B.y-C.y) + B.x*(C.y-A.y) + C.x*(A.y-B.y))/2
