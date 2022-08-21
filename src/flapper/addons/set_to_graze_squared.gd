extends Node

func _ready():
	var threshold_squared = owner.graze_threshold*owner.graze_threshold
	
	get_parent().min_power = threshold_squared
	get_parent().max_power = threshold_squared*10
	
