extends Node


func _ready():
	yield(owner,"ready")
	var parent = get_parent()
	NodeUtils.reparent(parent,owner.wearer)
	
