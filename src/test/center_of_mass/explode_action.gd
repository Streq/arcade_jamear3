extends Node2D

onready var enemy_detect = $enemy_detect
onready var collision_shape_2d = $hitbox/CollisionShape2D


export var power := 100*88

func trigger():
	for enemy in enemy_detect.get_overlapping_bodies():
		var dist = global_position.distance_squared_to(enemy.global_position)
		var dir = enemy.global_position-global_position if dist else Vector2.UP
		enemy.velocity += dir*power/dist
	collision_shape_2d.disabled = false
	get_parent().queue_free()
