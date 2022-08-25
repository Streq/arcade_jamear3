extends CanvasLayer


export (String, MULTILINE) var char_list = """1234567890
QWERTYUIOP
ASDFGHJKLÑ
ZXCVBNM
ÉÚÍÓÁËÜÏÖÄ
 
qwertyuiop
asdfghjklñ
zxcvbnm
éúíóáëüïöä
 
,.-;:_¡!?¿
"""
export var CHAR_BUTTON : PackedScene
export var SEND_BUTTON : PackedScene
export var DEL_BUTTON : PackedScene
export var max_name_length = 16
export var columns = 10

var resulting_name = "" 
onready var chars = $"%chars"
onready var _name = $"%name"


func _ready():
	var i = 0
	for c in char_list:
		var column = i%columns
		#if line break fill rest of row with spaces
		if c == "\n":
			#unless linebreak happens on first column, 
			#which coincides with auto linebreak from columns
			if !(column in [0]):
				for j in range(column, columns):
	#				chars.add_child(Control.new())
					var button: Button = CHAR_BUTTON.instance()
					button.text = " "
					button.connect("pressed", self, "_on_char_button_pressed", [" "])
					chars.add_child(button)
			i = 0
		else:
			var button: Button = CHAR_BUTTON.instance()
			button.text = c
			button.connect("pressed", self, "_on_char_button_pressed", [c])
			chars.add_child(button)
			i+=1
	
	add_delete_button()
	i+=1
	add_accept_button()
	i+=1
	while i != 0:
		var button: Button = CHAR_BUTTON.instance()
		button.text = " "
		button.connect("pressed", self, "_on_char_button_pressed", [" "])
		chars.add_child(button)
		i = (i+1)%columns
	
	add_wrap_around()
	update_name()
	disable()

func add_delete_button():
	var button: Button = DEL_BUTTON.instance()
	button.connect("pressed", self, "_delete")
	chars.add_child(button)
func add_accept_button():
	var button: Button = SEND_BUTTON.instance()
	button.connect("pressed", self, "_accept")
	chars.add_child(button)

func _accept():
	ScoreBoard.save_score(resulting_name, Score.total_time)
	ScoreDisplay.enable()
	self.disable()

func disable():
	visible = false
	set_process_input(false)
	set_process(false)

func enable():
	visible = true
	set_process_input(true)
	set_process(true)

	resulting_name = ""
	update_name()
	var button :Button = chars.get_child(0)
	yield(get_tree(),"idle_frame")
	button.grab_focus()

func _delete():
	var length = resulting_name.length()
	if length>0:
		resulting_name = resulting_name.substr(0,length-1)
		update_name()

func _on_char_button_pressed(c):
	if resulting_name.length() < max_name_length:
		resulting_name += c
		update_name()

func _process(delta):
	var current_name_length = resulting_name.length()
	if current_name_length < max_name_length:
		var cursor = current_name_length
		var secs = Time.get_ticks_msec()/1000.0
		if fmod(secs,1.0) > 0.5:
			_name.text[cursor] = " "
		else:
			_name.text[cursor] = "|"

func update_name():
	_name.text = resulting_name
	for i in max_name_length-resulting_name.length():
		if i == 0:
			_name.text += "|"
		else:
			_name.text += "."

func _input(event):
	if event.is_action_pressed("B"):
		_delete()

func add_wrap_around():
	var children = self.chars.get_children()
	var rows = chars.get_child_count()/chars.columns
	for i in chars.get_child_count():
		var button := children[i] as Button
		var column = i % columns
		var row = i / columns
		
		if column == 0:
			button.focus_neighbour_left = children[i+columns-1].get_path()
		if column == columns-1:
			button.focus_neighbour_right = children[i-(columns-1)].get_path()
		if row == 0:
			button.focus_neighbour_top = children[column+(rows-1)*columns].get_path()
		if row == rows-1:
			button.focus_neighbour_bottom = children[column].get_path()
		
		
