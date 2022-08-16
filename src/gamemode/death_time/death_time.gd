extends Node2D

export var initial_time = 30.0
export var decrement_factor = 1.0-1.0/30.0

onready var timer = $Timer
onready var tiempo = $CanvasLayer/tiempo
onready var puntaje = $CanvasLayer/puntaje

var total = 0.0

func _physics_process(delta):
	total+=delta*60.0
	tiempo.set_value("%.2f"%timer.time_left)
	puntaje.set_value("%d"%total)

func _on_seed_taken():
	timer.wait_time *= decrement_factor
	timer.start()
	total += 60*30


func _on_Timer_timeout():
	total = 0.0
	timer.wait_time = initial_time
	timer.start()
