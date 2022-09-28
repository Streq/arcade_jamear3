extends Node

func _physics_process(delta: float) -> void:
	get_parent().addons["energy"].value += 1.0
