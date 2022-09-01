extends Node

func _ready():
	yield(owner,"ready")
	owner.target = Group.get_one("flapper")
