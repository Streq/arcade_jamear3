extends Node2D


export var ARROW : PackedScene

export var shoot_speed = 500.0
export var spread_power = 20.0
export var amount = 5

export var spread_angle = 5.0


var predict = false

func shoot(wearer = owner):
	for i in amount:
		shoot_bullet(wearer, rand_range(deg2rad(-spread_angle),deg2rad(spread_angle)),rand_range(0,spread_power))
	
func shoot_bullet(wearer = owner, deviation_angle = 0.0, deviation_power = 0.0):
	var arrow = ARROW.instance()
	wearer.get_parent().add_child(arrow)
	arrow.global_rotation = global_rotation
	arrow.global_position = global_position
	arrow.velocity = Vector2.RIGHT.rotated(arrow.global_rotation+deviation_angle)*(shoot_speed+deviation_power)
	if "velocity" in wearer:
		arrow.velocity += wearer.velocity*0.1
	
