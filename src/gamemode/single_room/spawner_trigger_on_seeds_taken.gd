extends Node
signal trigger

export var seeds := 5

var current = 0


func _on_seed_taken():
	current += 1
	while current >= seeds:
		current -= seeds
		emit_signal("trigger")
