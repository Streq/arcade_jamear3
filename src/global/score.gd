extends CanvasLayer


export var time_difficulty = 0.0
export var level_difficulty = 0.0
onready var tiempo_label = $tiempo_label


export var total_time = 0.0

func _physics_process(delta):
	if Global.player_alive:
		total_time += delta

func _process(delta):
	var minutes = int(total_time)/60
	var seconds = fmod(total_time,60.0)
	var text = "%02d" % minutes + ":%05.2f" % seconds
	tiempo_label.text = text

func _ready():
	Global.connect("new_game", self, "_on_new_game")

func _on_new_game():
	total_time = 0.0
