extends Node


func _physics_process(delta):
	var flappers = Group.get_all("flapper")
	if flappers.size():
		var parent = get_parent()
		var current_distance = INF
		var current_target = null
		for flapper in flappers:
			var dist_to_check = parent.global_position.distance_squared_to(flapper.global_position)
			if dist_to_check < current_distance:
				current_distance = dist_to_check
				current_target = flapper
		get_parent().target = current_target
			
