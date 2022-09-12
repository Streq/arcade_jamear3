extends Node
signal trigger

export var seeds := 1
export var odds = 0.1
export var max_fails = 6
var current = 0

var fails_since_success = 0

func _on_seed_taken():
	current += 1
	while current >= seeds:
		current -= seeds
		if randf() <= odds or fails_since_success > max_fails:
			emit_signal("trigger")
			fails_since_success = 0
		else:
			fails_since_success += 1
