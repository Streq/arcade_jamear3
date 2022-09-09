extends Node2D
export var PLAYER : PackedScene
var player
var player_alive = true
var app_state_node


onready var player_spawn_point = $player_spawn_point

# Called when the node enters the scene tree for the first time.
func _ready():
	start()
	
func start():
	player = PLAYER.instance()
	add_child(player)
	player_alive = true
	player.connect("die",self,"_on_player_died")
	player.position = player_spawn_point.position


func _on_player_died():
	player_alive = false

func _input(event):
	if OS.is_debug_build():
		if event.is_action_pressed("next_level"):
			if !player_alive:
				start()
				player.position.x += rand_range(-200,200)
				player.position.y += rand_range(-100,100)
				
