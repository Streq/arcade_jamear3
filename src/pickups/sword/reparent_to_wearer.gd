extends Node


func _ready():
	yield(owner,"ready")
	var parent = get_parent()
	var hud = owner.wearer.HUD
	NodeUtils.reparent(parent,hud)
	hud.move_child(parent, 0)
