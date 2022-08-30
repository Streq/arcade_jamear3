extends Node


func _ready():
	if Difficulty.levels_completed > 0:
		get_parent().queue_free()
