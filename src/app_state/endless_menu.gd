extends CanvasLayer

var app_state_node


func _on_play_pressed():
	if is_instance_valid(app_state_node):
		app_state_node.push("endless")


func _on_back_to_menu_pressed():
	if is_instance_valid(app_state_node):
		app_state_node.pop()
