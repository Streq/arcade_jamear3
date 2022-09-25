extends Node
export var song := ""
func _ready() -> void:
	Music.play_music_no_crossfade(song)
