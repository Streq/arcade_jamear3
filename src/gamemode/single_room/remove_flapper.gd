extends Node


func _ready() -> void:
	get_parent().remove_from_group("flapper")
