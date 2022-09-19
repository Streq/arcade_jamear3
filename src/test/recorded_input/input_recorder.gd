extends Node

var events = []
var frame = 0

func _physics_process(delta: float) -> void:
	frame += 1
#onready var labels = {"ui_up":$"../up", "ui_right":$"../right", "ui_down":$"../down", "ui_left":$"../left"}

var reproducing = false

func _input(event: InputEvent) -> void:
	if !reproducing:
		if event.is_action("next_level"):
			reproduce()
		else:
			for action in ["A","B","ui_left","ui_right","ui_down","ui_up"]:
				if event.is_action(action):
					var e = InputEventAction.new()
#					var e = {}
					e.pressed = event.is_action_pressed(action)
					e.action = action+"_demo"
					e.strength = event.get_action_strength(action)
#					labels[action].text = str(event.get_action_strength(action))
					
					events.append({"frame":frame, "event":e})
					Input.parse_input_event(e)

func reproduce():
	reproducing = true
	var frame = 0
	for e in events:
		for i in (e.frame-frame):
			yield(get_tree(),"physics_frame")
			frame += 1
		Input.parse_input_event(e.event)
	reproducing = false
	events = []
	self.frame = 0
