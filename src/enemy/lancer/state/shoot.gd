extends State

func _enter(params):
	var anim : AnimationPlayer = owner.animation_player
	anim.play("shoot")
	anim.connect("animation_finished",self,"_on_animation_finished")

func _exit():
	var anim : AnimationPlayer = owner.animation_player
	anim.disconnect("animation_finished",self,"_on_animation_finished")

func _on_animation_finished(anim):
	goto("idle")

func _physics_update(delta: float):
	if owner.sight.can_see(owner.target):
		owner.aim.aim_at(owner.target)
