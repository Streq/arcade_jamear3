extends Node

export var FEATHER: PackedScene

export var initial_speed := 300.0
export var inertia_multiplier := 1.0
export var amount := 1
const MAX_FEATHERS = 500

func throw_feathers(inertia, amount, rand_initial_speed, inertia_multiplier):
	for i in amount:
		if Group.get_all("feather").size()>MAX_FEATHERS:
			return
		var instance = FEATHER.instance()
		instance.rotation = randf()*TAU
		instance.velocity = Vector2.LEFT.rotated(randf()*TAU)*rand_initial_speed
		owner.get_parent().add_child(instance)
		instance.global_position = owner.global_position
		instance.velocity += inertia*inertia_multiplier
		
		instance.sprite.material = owner.sprite.material
