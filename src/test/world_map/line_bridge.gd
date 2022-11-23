extends Line2D


func _ready():
	var space_state = get_world_2d().direct_space_state
	var nodes = []
	for point in points:
		var query_result = space_state.intersect_point(global_transform.xform(point),1,[],1,false,true)
		if query_result.size() == 1:
			nodes.append(query_result[0].collider.get_parent())
	
	if !nodes.empty() and nodes.size()%2 == 0:
		for i in nodes.size()/2:
			nodes[i*2].link_with(nodes[i*2+1])
