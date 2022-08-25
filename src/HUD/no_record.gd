extends VBoxContainer

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
		ScoreDisplay.enable()
		owner.disable()
	if event.is_action_pressed("B"):
		owner.disable()
		Global.new_game()
