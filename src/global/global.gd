extends Node

signal player_dead()
signal player_is_alive()
signal portal_open()
signal new_level()

export var time_difficulty = 0.0
export var level_difficulty = 0.0


export var total_time = 0.0

export var records := PoolRealArray()

export var exit_portal_velocity = Vector2()

func _input(event):
	if event.is_action_pressed("full_screen"):
		OS.window_fullscreen = !OS.window_fullscreen

func _player_died():
	print("dude died")
	yield(get_tree().create_timer(1.0),"timeout")
	emit_signal("player_dead")
func _player_is_alive():
	emit_signal("player_is_alive")

func portal_open():
	emit_signal("portal_open")

func new_level():
	emit_signal("new_level")
