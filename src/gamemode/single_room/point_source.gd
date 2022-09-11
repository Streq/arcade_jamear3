extends PathFollow2D

func get_transform():
	unit_offset = rand_range(0.0,1.0)
	return self.global_transform

func get_random_point():
	return get_transform().origin
