extends State



func _enter(params):
	owner.state_animation.play("glide")
	pass


func _physics_update(delta):
	var vel :Vector2 = owner.velocity
	var normal :Vector2 = owner.direction
	var projected :Vector2 = vel.project(normal)

	if normal.dot(vel) < 0.0:
#		print("vel:",vel,", normal:",normal,", projected:",projected)
		
		if projected.length()>150.0:
			owner.state_animation.play("glide_fail")
			owner.velocity -= projected*projected.length()*0.01*delta
		else:
			owner.state_animation.play("glide")
			owner.velocity -= projected*projected.length()*0.1*delta
			
		
	elif projected.length()>250.0:
		owner.state_animation.play("glide_opposite_fail")
		
	if !Input.is_action_pressed("B"):
		goto("idle")
	if Input.is_action_just_pressed("A"):
		goto("glide_flap")
