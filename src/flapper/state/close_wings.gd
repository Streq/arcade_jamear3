extends State

var buffered_flap = false

func _enter(params):
	owner.state_animation.play("close_wings")
	owner.state_animation.connect("animation_finished", self, "_on_animation_finished")
	clear_buffer()

func clear_buffer():
	buffered_flap = false

func _physics_update(delta):
	if owner.input_state.A.is_just_pressed():
		buffered_flap = true

func _exit():
	owner.state_animation.disconnect("animation_finished", self, "_on_animation_finished")


func _on_animation_finished(anim_name):
	if buffered_flap:
		goto("flap")
	else:
		goto("idle")
