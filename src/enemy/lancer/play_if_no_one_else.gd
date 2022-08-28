extends AudioStreamPlayer2D


func trigger():
	for alert in Group.get_all("alert"):
		if alert.playing:
			return
	play()
