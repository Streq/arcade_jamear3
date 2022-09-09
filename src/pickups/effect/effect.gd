extends Node

export var amount := 200.0
func apply(flapper:Node2D):
	clone(flapper, flapper.velocity.rotated(PI/6))
	clone(flapper, flapper.velocity.rotated(-PI/6))
	clone(flapper, flapper.velocity.rotated(PI/3))
	clone(flapper, flapper.velocity.rotated(-PI/3))

func clone(flapper:Node2D, dir):
	var clone = flapper.duplicate()
	owner.get_parent().call_deferred("add_child",clone)
	clone.set_deferred("velocity",dir)
	
