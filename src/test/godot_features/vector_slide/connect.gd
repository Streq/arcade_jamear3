extends Line2D
tool
signal update

func _ready():
	points = PoolVector2Array([Vector2(),Vector2()])
	get_parent().get_parent().connect("update",self,"update_pos")
func update_pos():
	points[0] = get_parent().global_position
	points[1] = get_parent().get_parent().global_position
	global_position = get_parent().get_parent().global_position
	emit_signal("update")
