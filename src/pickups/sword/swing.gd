extends Node

func _physics_process(delta):
	var wearer = owner.wearer
	owner.rotation = wearer.pivot.rotation
	
