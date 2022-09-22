extends State

var buffered_flap = false
func _enter(params):
	if owner.can_flap:
		owner.state_animation.play("glide_flap")
	else:
		owner.state_animation.play("failed_glide_flap")
	
	owner.state_animation.connect("animation_finished", self, "_on_animation_finished")
	clear_buffer()

func _exit():
	owner.state_animation.disconnect("animation_finished", self, "_on_animation_finished")

func clear_buffer():
	buffered_flap = false

func _physics_update(delta):
#	var vel :Vector2 = owner.velocity
#	var normal :Vector2 = owner.direction
#	var projected :Vector2 = vel.project(normal)
#
#	if normal.dot(vel) < 0.0:
#		print("vel:",vel,", normal:",normal,", projected:",projected)
#
#		owner.velocity -= projected*0.1

	if owner.turbo_flap or owner.input_state.A.is_just_pressed():
		buffered_flap = true


func _on_animation_finished(anim_name):
	if buffered_flap:
		if owner.input_state.B.is_pressed():
			goto("glide_flap")
		else:
			goto("flap")
		
	else:
		goto("glide")
