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
		SaveRecord.enable()
		self.disable()
	if event.is_action_pressed("B"):
		self.disable()
		Global.new_game()
