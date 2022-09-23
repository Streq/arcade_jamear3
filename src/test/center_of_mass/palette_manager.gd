extends Node
tool

var palettes = []

onready var initial_palette = $palette 

func _ready() -> void:
	palettes.append({"palette":initial_palette,"priority":0})
	update_parent_material()

func add_palette(palette):
	add_child(palette.palette)
	palettes.append(palette)
	palettes.sort_custom(self, "compare_by_priority")
	update_parent_material()

func remove_palette(palette):
	remove_child(palette.palette)
	palettes.erase(palette)
	update_parent_material()

func update_parent_material():
	var parent = get_parent()
	if "material" in parent:
		parent.material = palettes[-1].palette.material

func compare_by_priority(paletteA, paletteB):
	return paletteA.priority < paletteB.priority
