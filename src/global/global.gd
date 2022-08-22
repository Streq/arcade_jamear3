extends Node

export var time_difficulty = 0.0
export var level_difficulty = 0.0

func _input(event):
	if event.is_action_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
