extends State


func _enter(params):
	owner.state_animation.play("air")
	pass

func _physics_update(delta):
	if owner.input_state.A.is_just_pressed():
		goto("flap")
	if owner.input_state.B.is_pressed():
		goto("open_wings")
