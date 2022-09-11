extends CanvasLayer

var app_state_node

func _on_reanudar_pressed():
	app_state_node.pop()
	

func _on_volver_al_menu_pressed():
	app_state_node.pop()
	app_state_node.pop()
	
