extends Node2D
signal game_over
signal player_alive
signal player_dead

export var PLAYER : PackedScene

var player
var player_alive = true setget set_player_alive
var app_state_node



onready var player_spawn_point = $player_spawn_point

# Called when the node enters the scene tree for the first time.
func _ready():
	start()

func set_player_alive(val):
	player_alive = val
	if player_alive:
		emit_signal("player_alive")
	else:
		emit_signal("player_dead")
func start():
	player = PLAYER.instance()
	add_child(player)
	self.player_alive = true
	_on_new_player_instance(player)
	player.position = player_spawn_point.position

func _on_new_player_instance(instance):
	instance.connect("die",self,"_on_player_died",[], CONNECT_PERSIST)
	instance.connect("duplicated",self,"_on_new_player_instance")

func _on_player_died():
	for flapper in Group.get_all("flapper"):
		if !flapper.dead:
			return
	self.player_alive = false
	
func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			if !player_alive:
				start()
				player.position.x += rand_range(-200,200)
				player.position.y += rand_range(-100,100)
	if event.is_action_pressed("pause"):
		pause()
func pause():
	if !game_over:
		app_state_node.push("pause")

func _on_go_back():
	app_state_node.pop()

var game_over = false
func _on_wait_on_game_over_timeout():
	game_over = true
	emit_signal("game_over")
