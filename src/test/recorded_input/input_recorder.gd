extends Node

var events = []
var saved_events = []
var frame = 0

func _physics_process(delta: float) -> void:
	frame += 1
#onready var labels = {"ui_up":$"../up", "ui_right":$"../right", "ui_down":$"../down", "ui_left":$"../left"}

var reproducing = false

func _input(event: InputEvent) -> void:
	if !reproducing and OS.is_debug_build():
		if event.is_action("next_level"):
			saved_events = events
			events = []
			reproduce()
		
		if event.is_action("prev_level"):
			var file := File.new()
			file.open("res://assets/data/demo.dat", File.WRITE)
			file.store_var(saved_events, true)
			file.close()
		
		if event.is_action("curr_level"):
			_load()
			reproduce()
		
		else:
			for action in ["A","B","ui_left","ui_right","ui_down","ui_up"]:
				if event.is_action(action):
					var e = InputEventAction.new()

					e.pressed = event.get_action_strength(action)>0.0
					e.action = action+"_demo"
					e.strength = event.get_action_strength(action)
					
#					var _dict = {}
#					for i in event.get_property_list():
#						if i.usage == 7:
#							_dict[i.name] = event[i.name]
#					print(_dict)
#					print({"pressed":e.pressed,"action":e.action,"strength":e.strength})
#					labels[action].text = str(event.get_action_strength(action))
					
					events.append({"frame":frame, "event":e})
#					Input.parse_input_event(e)

func _ready() -> void:
	if !OS.is_debug_build():
#	if true:
		_load()
		reproduce()
func _load():
	var file := File.new()
	file.open("res://assets/data/demo.dat", File.READ)
	saved_events = file.get_var(true)
	file.close()

func reproduce():
	reproducing = true
	var frame = 0
	for e in saved_events:
		for i in (e.frame-frame):
			yield(get_tree(),"physics_frame")
			frame += 1
		Input.parse_input_event(e.event)
	reproducing = false
	self.frame = 0
