extends Node2D

export var dotsize = 8.0
export var minimap_scale = 1.0/8.0

func _physics_process(delta):
	update()


func _draw():
	
	var rect = Rect2(0,0,dotsize,dotsize)
	
	var nodes = {
		"ghost":Color.red,
		"bat":Color.rebeccapurple,
		"seed":Color.green,
		"flapper":Color.darkorange,
		"lancero":Color.darkslategray,
		"death":Color.black
	}
	
	for key in nodes:
		var color = nodes[key]
		for n in get_tree().get_nodes_in_group(key):
			rect.position = n.global_position*minimap_scale - rect.size/2
			draw_rect(rect, color)
	
	for n in get_tree().get_nodes_in_group("seed"):
		var line :Line2D = n.line
		var points = Transform2D(0,n.global_position).scaled(Vector2(1,1)*minimap_scale).xform(line.points)
		if points.size()<2:
			continue
		draw_polyline(points, Color.green, 1.0, false)
	
