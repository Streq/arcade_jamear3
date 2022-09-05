extends VBoxContainer

signal display_score
signal go_back


func _ready():
	disable()

func enable():
	visible = true
	set_process_input(true)
func disable():
	visible = false
	set_process_input(false)
	
func _input(event):
	if event.is_action_pressed("A"):
		emit_signal("display_score")
		owner.disable()
	if event.is_action_pressed("B"):
		owner.disable()
		emit_signal("go_back")
