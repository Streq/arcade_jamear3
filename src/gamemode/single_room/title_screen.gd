extends CanvasLayer

onready var timer: Timer = $Timer


func _ready() -> void:
	timer.connect("timeout",self,"exit")
	visible = true
	get_tree().paused = true
	
func exit():
	get_tree().paused = false
	queue_free()
	Music.play_music_no_crossfade("castle")


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("A"):
		exit()
