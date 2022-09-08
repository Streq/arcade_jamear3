extends CanvasLayer

var app_state_node


func _on_tutorial_pressed():
	if is_instance_valid(app_state_node):
		app_state_node.push("tutorial")


func _on_endless_pressed():
	if is_instance_valid(app_state_node):
		app_state_node.push("endless_menu")
