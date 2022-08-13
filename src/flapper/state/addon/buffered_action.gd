extends Node

export var action := ""

func get_value() -> bool:
	return pressed

func _ready():
	var state = get_parent()
	state.connect("entered", self, "_on_entered")
	state.connect("physics_update", self, "_physics_update")
var pressed = false

func _on_entered():
	pressed = false

func _physics_update(delta):
	if Input.is_action_just_pressed(action):
		pressed = true
