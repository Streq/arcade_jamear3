extends Control


func _ready() -> void:
	get_tree().paused = true
	yield(get_tree().create_timer(4.0,true),"timeout")
	get_tree().paused = false
	queue_free()
