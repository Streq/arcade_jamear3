extends Area2D

onready var viewport = $"../Viewport"

var triggered = false


func _on_body_entered(body : KinematicBody2D):
	if triggered:
		return
	triggered = true
	yield(get_tree(), "idle_frame")
#	body.position = to_local(body.global_position)
	var pos = to_local(body.global_position)+viewport.size/2.0
	
	Global.exit_portal_velocity = body.velocity
	
	body.emit_signal("entered_portal", self)
	NodeUtils.reparent(body, viewport)
	body.global_position = pos
	get_parent()._on_exited()
	