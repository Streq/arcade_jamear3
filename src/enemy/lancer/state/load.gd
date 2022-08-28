extends State
var ready_to_shoot = false

func _enter(params):
	var anim = owner.animation_player
	anim.play("load")
	ready_to_shoot = false
	anim.connect("animation_finished",self,"_on_animation_finished")

func _exit():
	var anim = owner.animation_player
	anim.disconnect("animation_finished",self,"_on_animation_finished")

func _physics_update(delta: float):
	if owner.sight.can_see(owner.target):
		owner.aim.aim_at(owner.target)
	if ready_to_shoot:
		goto("shoot")

func _on_animation_finished(name):
	ready_to_shoot = true
