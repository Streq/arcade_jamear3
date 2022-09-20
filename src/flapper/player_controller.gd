extends Node

export var disabled = false
export var suffix = ""

func _input(event: InputEvent) -> void:
	if !disabled:
		if event.is_action_pressed("A"+suffix):
			get_parent().A.pressed = true
		elif event.is_action_released("A"+suffix):
			get_parent().A.pressed = false
		elif event.is_action_pressed("B"+suffix):
			get_parent().B.pressed = true
		elif event.is_action_released("B"+suffix):
			get_parent().B.pressed = false

func _physics_process(delta: float) -> void:
	if !disabled:
		get_parent().dir = InputUtils.get_vector("ui_left"+suffix,"ui_right"+suffix,"ui_up"+suffix,"ui_down"+suffix)
