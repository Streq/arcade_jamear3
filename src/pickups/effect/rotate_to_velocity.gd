extends Node


func _physics_process(delta: float) -> void:
	get_parent().rotation = get_parent().velocity.angle() 
