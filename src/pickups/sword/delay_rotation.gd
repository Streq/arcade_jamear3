extends Node
export var amount := 0.5
var prev_rotation = 0.0
var curr_rotation = 0.0
onready var prev_transform = get_parent().get_parent().global_transform
onready var curr_transform = get_parent().get_parent().global_transform
func _physics_process(delta):
	
#	prev_rotation = curr_rotation
#	curr_rotation = get_parent().get_parent().global_rotation
#	get_parent().global_rotation = lerp_angle(prev_rotation,curr_rotation,amount)
	prev_transform = curr_transform
	curr_transform = get_parent().get_parent().global_transform
	
	get_parent().global_transform = prev_transform.interpolate_with(curr_transform, amount)
	
