extends Node

onready var recorder: Node = $recorder

func _ready() -> void:
	recorder.load_recording()
	recorder.replay()
