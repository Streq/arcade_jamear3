extends State



func _enter(params):
	owner.state_animation.play("glide")
	pass


func _physics_update(delta):
	if !Input.is_action_pressed("B"):
		goto("idle")
	if Input.is_action_just_pressed("A"):
		goto("glide_flap")

	var vel :Vector2 = owner.velocity
	var normal :Vector2 = owner.direction
	var projected :Vector2 = vel.project(normal)
	
	if normal.dot(vel) < 0.0:
		print("vel:",vel,", normal:",normal,", projected:",projected)
		
		owner.velocity -= projected*5.0*delta
