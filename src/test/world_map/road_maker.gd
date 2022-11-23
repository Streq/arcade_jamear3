extends Node2D

func _ready():
	var children = get_children()
	for i in children.size()-1:
		var a = children[i]
		var b = children[i+1]
		link(a,b)

func link(a,b):
	if a.position.x < b.position.x:
		a.node_right = b
		b.node_left = a
	if a.position.x > b.position.x:
		a.node_left = b
		b.node_right = a
	if a.position.y < b.position.y:
		a.node_down = b
		b.node_up = a
	if a.position.y > b.position.y:
		a.node_up = b
		b.node_down = a
