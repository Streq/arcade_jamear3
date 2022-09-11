extends Node2D

func _physics_process(delta):
	var center = Vector2()
	var entities = Group.get_all("ghost")
	if !entities.size():
		return
	for entity in entities:
		center += entity.global_position
	center = center/entities.size()
	global_position = center
	get_parent().target = self
