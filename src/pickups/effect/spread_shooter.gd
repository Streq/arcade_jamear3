extends Node2D


export var ARROW : PackedScene

export var shoot_speed = 500.0
#rand power range, the power goes from 
export var spread_power = 20.0
export var amount = 5

export var spread_angle = 5.0
export var inertia_on_shoot := 0.0


var predict = false

func shoot(wearer = owner):
	for i in amount:
		shoot_bullet(wearer, global_rotation + rand_range(deg2rad(-spread_angle),deg2rad(spread_angle)),shoot_speed+rand_range(0,spread_power))
	
func shoot_bullet(wearer = owner, angle = 0.0, power = 0.0):
	var arrow = ARROW.instance()
	wearer.get_parent().add_child(arrow)
	arrow.global_rotation = global_rotation
	arrow.global_position = global_position
	arrow.velocity = Vector2.RIGHT.rotated(angle)*power + inertia_on_shoot*wearer.velocity
	if "velocity" in wearer:
		arrow.velocity += wearer.velocity*0.1
	
