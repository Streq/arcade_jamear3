extends Node2D
tool
signal update
export var vector : Vector2
export var normal : Vector2
export var result : Vector2

export (float, 0, 360, 1) var rot = 0.0 setget set_rot

onready var _vector = $vector setget set_vector
onready var _normal = $normal
onready var _result = $result

func set_rot(val):
	rot = val
	update_stuff()

func update_stuff():
	property_list_changed_notify()
	normal = Vector2.RIGHT.rotated(deg2rad(rot))
	result = vector.slide(normal)
	_vector.global_position = vector
	_normal.global_position = normal*100
	_result.global_position = result
	emit_signal("update")
func set_vector(val):
	vector = val
	update_stuff()
func set_normal(val):
	normal = val.normalized()
	result = vector.slide(normal)
	update_stuff()
