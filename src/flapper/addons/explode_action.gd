extends Node

export var FEATHER: PackedScene

export var initial_speed := 300.0
export var inertia_multiplier := 1.0
export var amount := 1

func explode():
	for i in amount:
		var instance = FEATHER.instance()
		instance.rotation = randf()*TAU
		instance.velocity = Vector2.LEFT.rotated(randf()*TAU)*initial_speed
		get_tree().current_scene.add_child(instance)
		instance.global_position = owner.global_position
		instance.velocity += owner.velocity*inertia_multiplier
#	owner.queue_free()

