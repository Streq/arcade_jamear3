extends CanvasLayer


onready var pivot = $pivot

func _ready():
	Global.connect("portal_open", self, "portal_open")
	Global.connect("new_level", self, "new_level")
	Global.connect("player_dead", self, "player_dead")
	visible = false
func portal_open():
	visible = true

func player_dead():
	visible = false
	pass

func new_level():
	visible = false
	pass
	
