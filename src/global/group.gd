extends Node

func get_all(group: String) -> Array:
	return get_tree().get_nodes_in_group(group)

func get_one(group: String) -> Node:
	if get_tree().has_group(group):
		return get_tree().get_nodes_in_group(group)[0]
	else:
		return null

func exists(group: String) -> bool:
	return get_tree().has_group(group)

func get_children_in_group(group: String, node: Node):
	var ret = []
	for g in get_all(group):
		if node.is_a_parent_of(g):
			ret.append(g)

func get_first_parent_in_group(group: String, node: Node):
	var p = node.get_parent()
	while is_instance_valid(p):
		if p.is_in_group(group):
			return p
		p = p.get_parent()
		
	return null
	
