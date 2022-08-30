extends Node


func _ready():
	var flapper = Group.get_one("flapper")
	if flapper:
		flapper.connect("die",self,"_on_player_died")
	else:
		owner.queue_free()

func _on_player_died():
	owner.queue_free()
