extends Area2D

export var pull = 200.0
export var dist_unit = 1.0
export var friction = 0.0
export var max_pull = 1.0

func _physics_process(delta):
	for body in get_overlapping_bodies():
		var dir = body.global_position.direction_to(global_position)
		var dist_squared = body.global_position.distance_squared_to(global_position)
		if dist_squared:
			var power = min(max_pull/pull,dist_unit*dist_unit/dist_squared)
			body.velocity += dir*pull*power*delta
			body.velocity *= (1.0-friction*power*delta)
			
