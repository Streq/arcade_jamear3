extends CanvasLayer


onready var pivot = $pivot

var gameover = false

func enable():
	visible = true
	set_process_input(true)
func disable():
	visible = false
	set_process_input(false)
	

func _ready():
	set_process_input(false)
	Global.connect("player_is_alive", self, "_on_player_lives")
	Global.connect("player_dead", self, "_on_player_dead")
	
func _on_player_lives():
	disable()
func _on_player_dead():
	enable()

func _input(event):
	if event.is_action_pressed("B"):
		Global.new_game()
	if event.is_action_pressed("A"):
		disable()
		SaveRecord.enable()
		
	
	
	
	
