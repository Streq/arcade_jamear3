extends Node

export var input_state_path : NodePath
onready var input_state = get_node(input_state_path)

func _physics_process(delta: float) -> void:
#	var dir = InputUtils.get_vector("ui_left_demo","ui_right_demo","ui_up_demo","ui_down_demo")
#	get_parent().feed_state(dir,
#		Input.is_action_pressed("A_demo"),
#		Input.is_action_pressed("B_demo"))
	get_parent().feed_state(
		input_state.dir,
		input_state.A.is_pressed(),
		input_state.B.is_pressed()
		)
	
