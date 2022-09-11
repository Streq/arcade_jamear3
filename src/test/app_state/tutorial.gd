extends Node
onready var circuit = $circuit
onready var player_hud = $player_HUD


signal new_level(player)
signal new_game()
signal go_back()

var app_state_node

var player_alive = false

func start():
	circuit.current_level = -1
	
	circuit.next_level()
	player_alive = true
	emit_signal("new_game")

func _on_portal(portal):
	yield(portal,"player_exited")

	
func _on_level_finished():
	pass
func _on_next_level():
	var player = Group.get_one("flapper")
	if player:
		emit_signal("new_level", player)
		player.connect("entered_portal",self,"_on_portal")
		player.connect("die",self,"failure")
func failure():
	yield(get_tree().create_timer(1.0),"timeout")
	circuit.current_level -= 1
	circuit.next_level()
	pass

func _ready():
	if get_tree().current_scene != self:
		connect("go_back",get_parent(),"pop")
	start()	
		
func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			circuit.next_level()
	if event.is_action_pressed("pause"):
		pause()
func pause():
	app_state_node.push("pause")

func _on_new_game():
	start()


func _on_go_back():
	app_state_node.pop()
