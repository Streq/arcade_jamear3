extends CanvasLayer


onready var pivot = $pivot

func _ready():
	Global.connect("player_is_alive", self, "_on_player_lives")
	Global.connect("player_dead", self, "_on_player_dead")
	
func _on_player_lives():
	pivot.visible = false
	
func _on_player_dead():
	pivot.visible = true
	
