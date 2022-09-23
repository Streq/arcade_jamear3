extends Node

var max_amount := 5

func _on_pre_spawn() -> void:
	if Group.get_all("gemini").size()>0 \
	or Group.get_all("flapper").size() > max_amount:
		get_parent().weight = 0.0
	else:
		get_parent().weight = 1.0
	
