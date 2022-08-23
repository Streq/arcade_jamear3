extends CanvasLayer


onready var pivot = $pivot

var gameover = false

func _ready():
	set_process_input(false)
	Global.connect("player_is_alive", self, "_on_player_lives")
	Global.connect("player_dead", self, "_on_player_dead")

func _on_player_lives():
	
	set_process_input(false)
	pivot.visible = false
	
func _on_player_dead():
	set_process_input(true)
	pivot.visible = true

func _input(event):
	if event.is_action("A"):
		Global.new_game()
	
		
	
	
