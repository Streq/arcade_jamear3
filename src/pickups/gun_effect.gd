extends Node
export var GUN : PackedScene

func apply(flapper:Node2D):
	_instance(flapper)

func _instance(flapper:Node2D):
	var gun = GUN.instance()
	gun.pre_ready(flapper)
	flapper.pivot.add_child(gun)
	gun.owner = flapper
