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


func _player_died():
#	print("dude died")
	yield(get_tree().create_timer(1.0),"timeout")
	emit_signal("player_dead")
	player_alive = false
	
func _player_is_alive():
	emit_signal("player_is_alive")
	player_alive = true

func portal_open():
	emit_signal("portal_open")

func new_level():
	emit_signal("new_level")

func new_game():
	emit_signal("new_game")
#	Levels.current_level = 0
#	Levels.load_level()
	exit_portal_velocity = Vector2()
	
