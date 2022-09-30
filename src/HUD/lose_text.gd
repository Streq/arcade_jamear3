extends Label

export (Array, String, MULTILINE) var messages_ghost 
export (Array, String, MULTILINE) var messages_wall 

func _on_lose(cause):
	match cause:
		"hit":
			text = messages_ghost[randi()%messages_ghost.size()]
		"wall":
			text = messages_wall[randi()%messages_wall.size()]
	text+="\n(PERDISTE)"
	visible = true
