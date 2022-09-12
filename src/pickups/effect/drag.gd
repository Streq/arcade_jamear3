extends Node
export var drag := 1.0

func _physics_process(delta):
	owner.velocity*=(1-delta*drag)
