extends Sprite


func _physics_process(delta):
	var path = get_parent().path
	var target = get_parent().target
	if is_instance_valid(target) and path.size()>1:
		var dir = (path[-2]-path[-1]).normalized()
		global_rotation = dir.angle()
		global_position = target.global_position + dir*32.0
