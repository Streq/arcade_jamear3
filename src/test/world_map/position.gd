extends Position2D
tool

export (NodePath) onready var node_left = get_node(node_left) if node_left else null
export (NodePath) onready var node_right = get_node(node_right) if node_right else null
export (NodePath) onready var node_up = get_node(node_up) if node_up else null
export (NodePath) onready var node_down = get_node(node_down) if node_down else null


