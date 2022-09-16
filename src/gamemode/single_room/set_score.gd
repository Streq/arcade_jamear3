extends Node
export var to: NodePath
func _ready():
	yield(get_parent(),"ready")
	get_parent().score = get_node(to)
