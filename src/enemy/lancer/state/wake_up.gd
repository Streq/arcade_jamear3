extends State

func _enter(params):
	var anim = owner.animation_player
	anim.play("wake_up")
	anim.connect("animation_finished", self, "_on_animation_finished")
	
func _exit():
	var anim = owner.animation_player
	anim.disconnect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(name):
	goto("idle") 
