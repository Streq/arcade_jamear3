extends CanvasLayer

signal new_game
signal save_record
signal go_back


onready var score_display = $ScoreDisplay
onready var save_record = $SaveRecord

onready var pivot = $pivot
onready var new_record = $"%new_record"
onready var no_record = $"%no_record"

var gameover = false

var score setget set_score

func set_score(val):
	score = val
	save_record.score = score

func show_new_record():
	no_record.disable()
	new_record.enable()

func show_no_record():
	new_record.disable()
	no_record.enable()

func enable(param=null):
	if ScoreBoard.is_new_record(score.total_time):
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
	
func _on_player_lives():
	disable()
func _on_player_dead():
	enable()

func _on_new_game():
	emit_signal("new_game")
func _on_go_back():
	emit_signal("go_back")
