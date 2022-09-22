extends Node
signal win
enum {
	WIN = 1,
	LOSE = 2,
	QUIT = 0
}
onready var score: CanvasLayer = $"../score"
var won = false


func _physics_process(delta: float) -> void:
	if score.total_time >= 120.0:
		emit_signal("win")
		won = true
		yield(get_tree().create_timer(3.0),"timeout")
		_on_game_over()

func _on_game_over():
	if won:
		get_tree().quit(WIN)
	else:
		get_tree().quit(LOSE)

func _on_game_won():
	get_tree().quit(WIN)
	
func _unhandled_key_input(event: InputEventKey) -> void:
	if event.scancode == KEY_ESCAPE and event.is_pressed():
		get_tree().quit(QUIT)
