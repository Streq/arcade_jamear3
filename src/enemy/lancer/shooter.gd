extends Node2D



export var shoot_speed = 500.0

var predict = false

var pool

func _ready() -> void:
	pool = Group.get_one("arrow_pool")

func shoot(wearer = owner):
	var arrow = pool.get_one()
	if arrow:
		arrow.rotation = global_rotation
		arrow.position = global_position
		arrow.velocity = Vector2.RIGHT.rotated(arrow.rotation)*shoot_speed
		
