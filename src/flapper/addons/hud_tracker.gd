extends Node


func _ready():
	yield(get_parent(),"ready")
#	PlayerHud.track_energy(get_parent().addons["energy"])
