extends Node2D

export var initial_time = 30.0
export var decrement_factor = 1.0-1.0/30.0

onready var tiempo = $CanvasLayer/tiempo
onready var puntaje = $CanvasLayer/puntaje
onready var semillas_label = $CanvasLayer/semillas

var total = 0.0
var semillas = 0
var player_alive = true
func _physics_process(delta):
	if player_alive:
		total+=delta
		
	var minutes = int(total)/60
	var seconds = fmod(total,60.0)
	var text = "%02d" % minutes + ":%02d" % seconds
	
	puntaje.set_value(text)

func _on_seed_taken():
	semillas += 1
	semillas_label.set_value(str(semillas))
	 
func _on_player_dead():
	player_alive = false
