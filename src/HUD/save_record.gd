extends CanvasLayer


export var char_list = """
1234567890
QWERTYUIOP
ASDFGHJKLÑ
ZXCVBNM
"""
export var CHAR_BUTTON : PackedScene
export var max_name_length = 8


var resulting_name = "" 
onready var chars = $"%chars"
onready var _name = $"%name"


# Called when the node enters the scene tree for the first time.
func _ready():
	for c in char_list:
		if c != "\n":
			var button: Button = CHAR_BUTTON.instance()
			button.text = c
			button.connect("pressed", self, "_on_char_button_pressed", [c])
			chars.add_child(button)
	add_delete_button()
	add_accept_button()
	
	update_name()
	disable()

func add_delete_button():
	var button: Button = CHAR_BUTTON.instance()
	button.text = "<"
	button.modulate = Color.red
	button.connect("pressed", self, "_delete")
	chars.add_child(button)
func add_accept_button():
	var button: Button = CHAR_BUTTON.instance()
	button.text = " "
	button.modulate = Color.green
	button.connect("pressed", self, "_accept")
	chars.add_child(button)

func _accept():
	ScoreBoard.save_score(resulting_name, Score.total_time)
	ScoreDisplay.enable()
	self.disable()

func disable():
	visible = false
	set_process_input(false)

func enable():
	visible = true
	set_process_input(true)
	resulting_name = ""
	update_name()

func _delete():
	var length = resulting_name.length()
	if length>0:
		resulting_name = resulting_name.substr(0,length-1)
		update_name()

func _on_char_button_pressed(c):
	if resulting_name.length() < max_name_length:
		resulting_name += c
		update_name()
		
func update_name():
	_name.text = resulting_name
	for i in 8-resulting_name.length():
		_name.text += "_"

func _input(event):
	if event.is_action_pressed("B"):
		_delete()
	
