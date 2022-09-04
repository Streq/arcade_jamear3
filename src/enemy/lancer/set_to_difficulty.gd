extends Node
export var prop := ""
export var max_value := 0.0
export var min_value := 0.0
export var min_difficulty := 0.0
export var max_difficulty := 0.0


func _physics_process(delta):
	var mapped = range_lerp(
			owner.difficulty,
			min_difficulty,
			max_difficulty,
			min_value,
			max_value
		)
	var val = clamp(mapped, min_value, max_value)
	
	
	get_parent().set_indexed(prop, val)
	get_parent()
