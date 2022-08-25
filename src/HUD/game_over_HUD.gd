extends CanvasLayer


onready var pivot = $pivot
onready var new_record = $"%new_record"
onready var no_record = $"%no_record"

var gameover = false

func show_new_record():
	no_record.disable()
	new_record.enable()

func show_no_record():
	new_record.disable()
	no_record.enable()

func enable():
	if ScoreBoard.is_new_record(Score.total_time):
		show_new_record()
	else:
		show_no_record()
	visible = true
	set_process_input(true)
	
func disable():
	visible = false
	set_process_input(false)
	new_record.disable()
	no_record.disable()
	

func _ready():
	disable()
	Global.connect("player_is_alive", self, "_on_player_lives")
	Global.connect("player_dead", self, "_on_player_dead")
	
func _on_player_lives():
	disable()
func _on_player_dead():
	enable()


	
	
	
