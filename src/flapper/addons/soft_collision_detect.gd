extends Node


onready var feather_action = $"../feather_action"

export var amount = 10
export var rand_initial_speed = 300.0
export var inertia_multiplier = 1.0

func _on_collision(prev_vel, _post_vel):
	feather_action.throw_feathers(prev_vel, amount, rand_initial_speed, inertia_multiplier)

func _on_collision_no_args():
	feather_action.throw_feathers(Vector2(), amount, rand_initial_speed, inertia_multiplier)

