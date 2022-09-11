extends Node2D

export var fall_speed := 100.0

func _physics_process(delta):
	position.y += delta * fall_speed 
