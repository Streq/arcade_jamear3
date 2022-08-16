extends Node

export var FEATHER: PackedScene

export var initial_speed := 300.0
export var inertia_multiplier := 1.0
export var amount := 1


func throw_feathers(inertia, amount, rand_initial_speed, inertia_multiplier):
	for i in amount:
		var instance = FEATHER.instance()
		instance.rotation = randf()*TAU
		instance.velocity = Vector2.LEFT.rotated(randf()*TAU)*rand_initial_speed
		get_tree().current_scene.add_child(instance)
		instance.global_position = owner.global_position
		instance.velocity += inertia*inertia_multiplier
		
		instance.sprite.update_tex(owner.sprite.tex.get_data())
