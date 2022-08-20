extends Node2D


onready var polygon = $Polygon2D
onready var polygon2 = $Polygon2D2


func _ready():
#	polygon_2d.polygons = [PoolVector2Array([Vector2(2.5,2.5),Vector2(7.5,2.5),Vector2(7.5,7.5),Vector2(2.5,7.5)])]
#	polygon_2d.polygon = PoolVector2Array([Vector2(0,0),Vector2(10,0),Vector2(10,10),Vector2(0,10)])
	
	var polys = Geometry.offset_polygon_2d(polygon.polygon,-4.0, Geometry.JOIN_SQUARE)
	polygon2.polygon = polys[0]
	
	
