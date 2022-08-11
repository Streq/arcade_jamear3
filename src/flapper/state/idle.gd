extends State


func _enter(params):
	owner.state_animation.play("air")
	pass

func _physics_update(delta):
	if Input.is_action_just_pressed("A"):
		goto("flap")
	if Input.is_action_pressed("B"):
		goto("glide")
