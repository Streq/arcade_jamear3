extends Node
signal trigger

export var seeds := 1
export var odds = 0.1

var current = 0

func _on_seed_taken():
	current += 1
	while current >= seeds:
		current -= seeds
		if randf() <= odds:
			emit_signal("trigger")
