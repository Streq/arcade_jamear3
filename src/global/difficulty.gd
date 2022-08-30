extends Node

onready var dificultad_label = $dificultad_label

var levels_completed = -1
var last_difficulty = 0.0
var base_difficulty = 0.0
var score_offset = 0.0

export var start_difficulty := 0.0
export var difficulty_increase_scale := 1.0
export var difficulty_decrease_per_level_compeltion := 20.0
export var difficulty_increase_per_level := 10.0

func get_difficulty():
#	return 380.0
	return start_difficulty + _get_base_difficulty()

func _get_base_difficulty():
	return base_difficulty + (Score.total_time - score_offset)*difficulty_increase_scale

func _ready():
	Global.connect("new_level", self, "_on_level_completed")
	Global.connect("new_game", self, "_on_new_game")

func _on_new_game():
	base_difficulty = -10.0
	last_difficulty = 0.0
	levels_completed = -1
	
func _on_level_completed():
#	cuando yo gano un nivel, quiero que la dificultad baje 30 sec 
#	si la diferencia entre la dificultad en el nivel anterior+10 
#	y la dificultad en este nivel es mayor a 30, si no, 
#	que baje a la dificultad del nivel anterior+10
	base_difficulty = max(base_difficulty+difficulty_increase_per_level, _get_base_difficulty()-difficulty_decrease_per_level_compeltion)
	levels_completed += 1
	score_offset = Score.total_time


func _physics_process(delta):
	dificultad_label.text = "dificultad: %.2f" % get_difficulty()
