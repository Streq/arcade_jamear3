extends Node2D
tool
signal finished
signal start


onready var base_particle = $"0"

func _on_0_finished():
	emit_signal("finished")
	queue_free()

func start():
	emit_signal("start")

func _ready():
	start()
