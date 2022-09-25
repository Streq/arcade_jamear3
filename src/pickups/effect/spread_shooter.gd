extends Node2D


export var shoot_speed = 500.0
#rand power range, the power goes from 
export var spread_power = 20.0
export var amount = 5

export var spread_angle = 5.0
export var inertia_on_shoot := 0.0
export var delay_random := 0.1

export var pool_name := "gun_bullet_pool"

var predict = false
var pool
func _ready() -> void:
	pool = Group.get_one(pool_name)
	
func shoot(wearer = owner.owner):
	for i in amount:
		shoot_bullet(wearer, global_rotation + rand_range(deg2rad(-spread_angle),deg2rad(spread_angle)),shoot_speed+rand_range(0,spread_power))
	
func shoot_bullet(wearer = owner, angle = 0.0, power = 0.0):
	var arrow = pool.get_one()
	if arrow:
		arrow.position = global_position
		var bullet_vel = Vector2.RIGHT.rotated(angle)*power
		arrow.velocity = bullet_vel + inertia_on_shoot*wearer.velocity
		arrow.global_rotation = bullet_vel.angle()
		arrow.scale*=scale
