extends Node2D

export var range_of_sight = 1000.0
export var can_see_through_walls = false

export(int, LAYERS_2D_PHYSICS) var opaque_layers

func can_see(target: PhysicsBody2D):
	if is_instance_valid(target):
		var angle = rad2deg(get_angle_to(target.global_position))
		if global_position.distance_squared_to(target.global_position) < range_of_sight*range_of_sight:
			if can_see_through_walls:
				return true;
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(global_position, target.global_position, [target], opaque_layers)
			return !result.has("collider") or result.collider == target
	return false
