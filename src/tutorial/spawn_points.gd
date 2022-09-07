extends Node2D

var index = 0
#returns random point in global_coords
func get_random_point() -> Vector2:
	var rand_point = get_children()[index%get_child_count()].position
	index += 1
	return global_transform.xform(rand_point)
