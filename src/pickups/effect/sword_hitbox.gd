extends Area2D

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
	on.velocity += get_knockback(on.global_position)
	
func get_knockback(point_of_impact := Vector2()):
	var point = point_of_impact - owner.global_position
	if point:
		var dist = point.length()
		var linear_speed = dist * angular_speed
		var dir = -point.tangent()/dist
		var knockback = dir*linear_speed
		print(knockback)
		return knockback*self.knockback+owner.wearer.velocity
#		return Vector2.DOWN.rotated(global_rotation)*knockback
	
