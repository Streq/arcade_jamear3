extends CanvasLayer


onready var pivot = $pivot

func _ready():
	Global.connect("portal_open", self, "portal_open")
	Global.connect("new_level", self, "new_level")
	Global.connect("player_dead", self, "player_dead")
	
func portal_open():
	pivot.visible = true

func player_dead():
	pivot.visible = false

func new_level():
	pivot.visible = false
	
