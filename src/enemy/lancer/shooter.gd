extends Node2D


export var ARROW : PackedScene

export var shoot_speed = 500.0

var predict = false

func shoot():
	var arrow = ARROW.instance()
	owner.get_parent().add_child(arrow)
	arrow.global_rotation = global_rotation
	arrow.global_position = global_position
	arrow.velocity = Vector2.RIGHT.rotated(arrow.global_rotation)*shoot_speed

