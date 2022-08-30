extends Node
export var song := ""
func _ready():
	Music.play_music(song)
