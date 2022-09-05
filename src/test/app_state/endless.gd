extends Node
onready var circuit = $circuit
onready var difficulty = $difficulty
onready var score = $score
onready var player_hud = $player_HUD
onready var gameover_hud = $gameover_HUD

export var PLAYER : PackedScene

signal new_level(player)
signal new_game()
signal go_back()

var player_alive = false
var player
func start():
	circuit.current_level = -1
	score._on_new_game()
	player = PLAYER.instance()
	player.connect("die", self, "failure")
	player.connect("entered_portal", self,"_on_portal")
	circuit.next_level()
	player_alive = true
	emit_signal("new_game")

func _on_portal(portal):
	yield(portal,"player_exited")

func _on_level_finished():
	if player.is_inside_tree():
		player.get_parent().remove_child(player)
func _on_next_level():
	Group.get_one("player_spawn").spawn(player)
	emit_signal("new_level", player)
	
	
func failure():
	player_alive = false
	yield(get_tree().create_timer(1.0),"timeout")
	gameover_hud.enable()
	pass

func _ready():
	difficulty.score = score
	gameover_hud.score = score
	if get_tree().current_scene == self:
		start()
		
func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			circuit.next_level()

func _on_new_game():
	start()


func _on_go_back():
	emit_signal("go_back")
