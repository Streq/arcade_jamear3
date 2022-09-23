extends CanvasLayer

var app_state_node


func _input(event):
	if event.is_action_pressed("A") or event.is_action_pressed("B"):
		exit()

func exit():
	if is_instance_valid(app_state_node):
		app_state_node.switch("menu")
	

func _ready() -> void:
	get_tree().paused = true
	yield(get_tree().create_timer(4.0,true),"timeout")
	get_tree().paused = false
	exit()
