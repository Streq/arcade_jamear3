extends Node


func _physics_process(delta):
	var s = sign(owner.dir.x)
	if s:
		owner.sprite.flip_h = s<0.0
