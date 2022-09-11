extends Node

var anims = {}

var originals = {}

func _ready():
	var player = get_parent()
	yield(owner,"ready")
	
	
	for anim in player.get_animation_list():
		originals[anim] = player.get_animation(anim).length
	update_lengths()

func update_lengths():
	var player = get_parent()
	for anim in originals:
		anims[anim] = originals[anim]
	for anim in owner.custom_animation_lengths:
		var length = owner.custom_animation_lengths[anim]
		if length >= 0.0:
			anims[anim] = length
	for anim in anims:
		player.get_animation(anim).length = anims[anim]
