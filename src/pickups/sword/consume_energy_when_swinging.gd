extends Node


var prev_rot = 0.0
var rot = 0.0
var angular_speed = 0.0

func _physics_process(delta):
	prev_rot = rot
	rot = owner.global_rotation
	var delta_rot = Math.angle_distance(prev_rot, rot)
	owner.wearer.addons["energy"].add_value(-abs(delta_rot)*0.4)
