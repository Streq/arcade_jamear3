extends State



func _enter(params):
	owner.state_animation.play("glide")
	pass


func _physics_update(delta):
	var vel :Vector2 = owner.velocity
	var normal :Vector2 = owner.direction
	var projected :Vector2 = vel.project(normal)

	owner.state_animation.play("glide")
	if normal.dot(vel) < 0.0:
#		print("vel:",vel,", normal:",normal,", projected:",projected)
		
		if projected.length()>owner.glide_break_threshold:
			owner.state_animation.play("glide_fail")
			owner.velocity -= projected*projected.length()*owner.broken_glide_friction*delta
		else:
			owner.velocity -= projected*projected.length()*owner.glide_friction*delta
	
		
	elif projected.length()>owner.glide_opposite_break_threshold:
		owner.state_animation.play("glide_opposite_fail")
		
	if !Input.is_action_pressed("B"):
		goto("close_wings")
	if Input.is_action_just_pressed("A"):
		goto("glide_flap")
