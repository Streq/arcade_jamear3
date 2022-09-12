extends Node

export var threshold_squared = 100.0

func _physics_process(delta):
	if owner.velocity.length_squared() <= threshold_squared:
		owner.queue_free()
