extends Node2D

export var POINT : PackedScene
onready var polygon = $polygon

func _physics_process(delta):
	if Input.is_action_pressed("A"):
		for i in 100:
			var point : Node2D = POINT.instance()
			add_child(point)
			var poly = polygon.polygon
			point.position = GeometryUtils.random_point_in_polygon(poly)

