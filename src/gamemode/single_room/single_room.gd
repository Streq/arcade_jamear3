extends Node2D


var player_alive = true
onready var player = $fast_glider
var app_state_node
# Called when the node enters the scene tree for the first time.
func _ready():
	player_alive = true
	player.connect("die",self,"_on_player_died")
	
func _on_player_died():
	player_alive = false
