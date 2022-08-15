extends Node2D
onready var camera = $"%camera"
var current = 0


func _input(event):
	if event.is_action_pressed("next"):
		current = posmod(current+1, get_child_count())
		update_cam()
	if event.is_action_pressed("prev"):
		current = posmod(current-1, get_child_count())
		update_cam()
	
func update_cam():
	camera.get_parent().remove_child(camera)
	get_child(current).add_child(camera)
	camera.position = Vector2()
