extends Node

onready var palette = $palette
onready var palette_entry = {"priority":1, "palette":palette}


func setup() -> void:
	var flapper = owner.wearer
	remove_child(palette)
	flapper.palette_manager.add_palette(palette_entry)


func remove() -> void:
	var flapper = owner.wearer
	flapper.palette_manager.remove_palette(palette_entry)
