extends Node

onready var recorder = $recorder
onready var replayer = $replayer

func _ready() -> void:
	recorder.record()
	replayer.saved_events = recorder.events
	yield(get_tree().create_timer(1.0), "timeout")
	replayer.replay()
