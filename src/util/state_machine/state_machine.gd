extends Node
class_name StateMachine
signal state_changed(state)

export (String) var start_state

var current: State = null
var states:= {}


func initialize():
	for state in get_children():
		states[state.name] = state
		state.connect("finish", self, "_change_state")
	current = states[start_state]
	current.enter(null)

func physics_update(delta: float):
	current.physics_update(delta)

func update(delta: float):
	current.update(delta)

func handle_input(event: InputEvent):
	current._handle_input(event)

func _change_state(state_name: String, params):
	current.exit()
	current = states[state_name]
	current.enter(params)
	emit_signal("state_changed", state_name)
