extends Position2D
tool

export var disabled := false
export var clear := false

export (NodePath) var node_left
export (NodePath) var node_right
export (NodePath) var node_up
export (NodePath) var node_down


export var lmao := {"sos":"sas"}

func get_road_node(dir:Vector2):
	var node = null
	match dir:
		Vector2.LEFT:
			node = get_if_can_travel(node_left)
		Vector2.RIGHT:
			node = get_if_can_travel(node_right)
		Vector2.UP:
			node = get_if_can_travel(node_up)
		Vector2.DOWN:
			node = get_if_can_travel(node_down)
	
	return node

func get_if_can_travel(node_path):
	var node = get_node_if_present(node_path)
	if !is_instance_valid(node):
		return null
	if node.disabled:
		return null
	if node.clear:
		return node
	
	if self.clear:
		return node
	
	return null

func get_node_if_present(node):
	if node and has_node(node):
		return get_node(node)
	else:
		return null

func link_with(node):
	link(self,node)

static func link(a,b):
	if a.global_position.x < b.global_position.x:
		a.node_right = b.get_path()
		b.node_left = a.get_path()
	if a.global_position.x > b.global_position.x:
		a.node_left = b.get_path()
		b.node_right = a.get_path()
	if a.global_position.y < b.global_position.y:
		a.node_down = b.get_path()
		b.node_up = a.get_path()
	if a.global_position.y > b.global_position.y:
		a.node_up = b.get_path()
		b.node_down = a.get_path()

func _ready():
	pass
