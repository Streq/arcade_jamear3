extends Area2D

onready var viewport = $"../Viewport"

var triggered = false

var exceptions = []

func _on_body_entered(body : KinematicBody2D):
	if body in exceptions:
		return
	
	exceptions.append(body)
	
#	if triggered:
#		return
	
	yield(get_tree(), "idle_frame")
#	body.position = to_local(body.global_position)
	var pos = to_local(body.global_position)+viewport.size/2.0
	
	body.emit_signal("entered_portal", owner)
	
	NodeUtils.reparent(body, viewport)
	body.global_position = pos
	if body.is_in_group("flapper"):
		get_parent()._on_exited()
		triggered = true
	
	

func _on_body_exited(body : KinematicBody2D):
#	print("exit")
	pass
