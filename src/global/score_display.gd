extends CanvasLayer

signal go_back()

export var RECORD : PackedScene
onready var entry_list = $"%entry_list"
onready var play_again = $"%play_again"


func enable():
	visible = true
	set_process_input(true)
	update_display()

func disable():
	visible = false
	set_process_input(false)

func _ready():
	update_display()
	disable()

func update_display():
	for child in entry_list.get_children():
		entry_list.remove_child(child)
		
	var records = ScoreBoard.board
#	var records = []
	var i = 0
	for record in records:
		i += 1
		var entry = RECORD.instance()
		entry.from(i, record.name, record.score)
		entry_list.add_child(entry)
	entry_list.add_child(play_again)

func _input(event):
	if event.is_action_pressed("B"):
		disable()
		emit_signal("go_back")
