extends Node2D
tool
func _ready():
	var children = get_children()
	for i in children.size()-1:
		var a = children[i]
		var b = children[i+1]
		link(a,b)

func link(a,b):
	if a.position.x < b.position.x:
		a.node_right = b.get_path()
		b.node_left = a.get_path()
	if a.position.x > b.position.x:
		a.node_left = b.get_path()
		b.node_right = a.get_path()
	if a.position.y < b.position.y:
		a.node_down = b.get_path()
		b.node_up = a.get_path()
	if a.position.y > b.position.y:
		a.node_up = b.get_path()
		b.node_down = a.get_path()
