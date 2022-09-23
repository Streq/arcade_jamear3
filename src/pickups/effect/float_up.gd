extends Node

export var acceleration := 0.0

func _physics_process(delta: float) -> void:
	owner.velocity.y -= delta*acceleration
