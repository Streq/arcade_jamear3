extends Node


export var random_range := 0.25


func _ready() -> void:
	get_parent().wait_time = get_parent().wait_time+randf()*random_range
