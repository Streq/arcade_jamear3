extends Node

func _ready():
	var threshold_squared = owner.graze_threshold*owner.graze_threshold
	
	get_parent().min_power = 0
	get_parent().max_power = threshold_squared+200
	
