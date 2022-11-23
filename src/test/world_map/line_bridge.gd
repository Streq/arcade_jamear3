extends Line2D
tool
export var multiline := false
export var _width := 10.0

func _ready():
	if multiline:
		for i in points.size()/2:
			var a = points[i*2]
			var b = points[i*2+1]
			link_points(a,b)
	else:
		for i in points.size()-1:
			var a = points[i]
			var b = points[i+1]
			link_points(a,b)
func link_points(a,b):
	var space_state = get_world_2d().direct_space_state
	
	var point_a = global_transform.xform(a)
	var result_a = space_state.intersect_point(point_a,1,[],1,false,true)
	
	if result_a.size() > 0:
		var point_b = global_transform.xform(b)
		var result_b = space_state.intersect_point(point_b,1,[],1,false,true)
		if result_b.size() > 0:
			var node_a = result_a[0].collider.get_parent()
			var node_b = result_b[0].collider.get_parent()
			node_a.link_with(node_b)


func _process(delta):
	update()
func _draw():
	if multiline:
		for i in points.size()/2:
			draw_line(points[i*2],points[i*2+1],default_color,_width)
	else:
		for i in points.size()-1:
			draw_line(points[i],points[i+1],default_color,_width)
