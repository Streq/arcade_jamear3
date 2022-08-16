extends Node
class_name GeometryUtils

#if you gonna use it a lot, you might prefer to cache the results of 
#get_triangulated and get_triangle_areas
#and call random_point_in_triangle(random_triangle_weighted_by_area(triangles,areas))
static func random_point_in_polygon(polygon: PoolVector2Array):
	var triangles = get_triangulated(polygon)
	return random_point_in_triangles(triangles, get_triangle_areas(triangles))

static func get_triangulated(polygon):
	var indexes = Geometry.triangulate_polygon(polygon)
	var triangles = PoolVector2Array()
	for i in indexes:
		triangles.append(polygon[i])
	return triangles

static func random_point_in_triangles(triangles: PoolVector2Array, weights: PoolRealArray):
	# if you don't weigh by area you get smaller triangles concentrating all them points!!!!!
	var i = random_weighted(weights)*3
#	var i = (randi()%(triangles.size()/3))*3
	return random_point_in_triangle(triangles[i], triangles[i+1], triangles[i+2])

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

static func random_weighted(weights: PoolRealArray)->int:
	var sum = weights[-1]
	var r = rand_range(0, sum)
	var i = 0
	while i < weights.size()-1:
		r -= weights[i]
		if r <= 0:
			break
		i += 1
	return i
