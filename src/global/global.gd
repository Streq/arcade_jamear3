extends Node

signal player_dead()
signal player_is_alive()
signal portal_open()
signal new_level()
signal new_game()

onready var gamemode = $gamemode



export var records := PoolRealArray()

export var exit_portal_velocity = Vector2()

var player_alive = false

func _input(event):
	if event.is_action_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if OS.is_debug_build():
		if event.is_action_pressed("restart"):
			get_tree().reload_current_scene()


	
