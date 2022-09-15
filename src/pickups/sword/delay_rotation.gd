extends Node

var prev_rotation = 0.0
var curr_rotation = 0.0
func _physics_process(delta):
	prev_rotation = curr_rotation
	curr_rotation = get_parent().get_parent().global_rotation
	get_parent().global_rotation = lerp_angle(prev_rotation,curr_rotation,0.5)
	
