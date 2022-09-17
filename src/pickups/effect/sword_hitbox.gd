extends Area2D

signal hit(area)

export var knockback := 200.0


var prev_rot = 0.0
var rot = 0.0
var angular_speed = 0.0

func _physics_process(delta):
	prev_rot = rot
	rot = owner.global_rotation
	var delta_rot = Math.angle_distance(prev_rot, rot)
	angular_speed = delta_rot
	

func apply_knockback(on):
	on.velocity += get_knockback(on)
	
func get_knockback(target):
	
	var global_point = target.global_position
	var local_point = global_point - owner.global_position
	if local_point:
		var dist = local_point.length()
		var linear_speed = dist * angular_speed
		var tangent_dir = -local_point.tangent()/dist
		var point_velocity_of_hitbox = tangent_dir*linear_speed
		var center_linear_velocity = owner.wearer.velocity
		var target_velocity = target.velocity
		var velocity_of_impact = point_velocity_of_hitbox
		var ret = knockback*velocity_of_impact-target_velocity+center_linear_velocity
		return ret
#		return Vector2.DOWN.rotated(global_rotation)*knockback

func calc_damage(knockback_vec):
	var knockback = knockback_vec.length_squared()
	print_debug("knockback:",knockback)
	if knockback > 500*500:
		return 3.0
	if knockback > 250*250:
		return 2.0
	return 1.0


func can_hit(target):
	return !(target.owner in get_parent().hits)

func register_hit(area):
	emit_signal("hit",area)
	var knockback = get_knockback(area.owner)
	area.take_knockback(knockback)
	var damage = calc_damage(knockback)
	print_debug("damage:", damage)
	area.take_damage(damage)
