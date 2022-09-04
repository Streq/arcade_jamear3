extends CanvasLayer
onready var circuit = $circuit
onready var difficulty = $difficulty
onready var score = $score

var player_alive = false


func start():
	circuit.next_level()
	player_alive = true


func failure():
	pass

func _ready():
	difficulty.score = score
	if get_tree().current_scene == self:
		start()
