extends CanvasLayer

var app_state_node



func _on_AnimationPlayer_animation_finished(anim_name):
	if is_instance_valid(app_state_node):
		app_state_node.switch("menu")
	
