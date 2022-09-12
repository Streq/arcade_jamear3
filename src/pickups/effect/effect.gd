extends Node

export var amount := 200.0
func apply(flapper:Node2D):
	flapper.filename
	var vel = flapper.velocity
	var hp = PI/2
	if vel:
#		vel = (flapper.velocity.normalized()*100.0).rotated(hp/2)
		vel = flapper.velocity.tangent().normalized()*50
	else:
		vel = Vector2.LEFT*50.0
	var inertia = flapper.velocity
#	clone(flapper, inertia + vel.rotated(hp))
#	clone(flapper, inertia + vel.rotated(hp*2))
#	clone(flapper, inertia + vel.rotated(hp*3))
#	clone(flapper, inertia + vel.rotated(hp*4))
	var loaded = load(flapper.filename)
	for i in range(1,4):
		clone(flapper, inertia + vel * i,loaded)
		clone(flapper, inertia + vel * -i,loaded)
	
func clone(flapper:Node2D, dir, loaded):
	call_deferred("_clone_from_file_deferred", flapper, dir, loaded)
func clone2(flapper:Node2D, dir):
	call_deferred("_clone_deferred", flapper, dir)

func _clone_deferred(flapper:Node2D, dir):
	var clone = flapper.duplicate()
	flapper.get_parent().add_child(clone)
	clone.velocity = dir
	fill_energy(clone)

func _clone_from_file_deferred(flapper:Node2D, dir:Vector2, packed: PackedScene):
	var clone = packed.instance()
	flapper.get_parent().add_child(clone)
	clone.velocity = dir
	clone.global_position = flapper.global_position
	clone.direction = flapper.direction
	flapper.emit_signal("duplicated", clone)
	


func fill_energy(clone):
	var energy = clone.addons["energy"]
	energy.value = energy.max_value
