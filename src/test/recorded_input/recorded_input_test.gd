extends Node2D

onready var joystick_hud: Node2D = $"%joystick_HUD"
onready var joystick_hud2: Node2D = $"%joystick_HUD2"

func _physics_process(delta: float) -> void:
	var a_mano=Vector2(
			Input.get_action_strength("ui_right_demo",true)
			-Input.get_action_strength("ui_left_demo",true),
			Input.get_action_strength("ui_down_demo",true)
			-Input.get_action_strength("ui_up_demo",true)
		).limit_length()
	var a_mano2 = InputUtils.get_vector("ui_left_demo","ui_right_demo","ui_up_demo","ui_down_demo")
	var baked = Input.get_vector("ui_left_demo","ui_right_demo","ui_up_demo","ui_down_demo")
#	inverse_lerp(p_deadzone, 1.0f, length) / length
	joystick_hud2.feed_state(InputUtils.get_vector("ui_left","ui_right","ui_up","ui_down"),Input.is_action_pressed("A_demo"),Input.is_action_pressed("B_demo"))


func _input(event: InputEvent) -> void:
	if !event.is_pressed():
		for action in ["ui_left_demo","ui_right_demo","ui_up_demo","ui_down_demo"]:
			if event.is_action(action):
				print(action+" released:")
