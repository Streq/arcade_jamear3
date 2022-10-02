extends Area2D

func senses_something():
	return get_overlapping_areas().size()>0
