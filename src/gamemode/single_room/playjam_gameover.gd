extends Node
signal win
signal loss(cause)
enum {
	WIN = 1,
	LOSE = 2,
	QUIT = 0
}
onready var score: CanvasLayer = $"../score"
var won = false


func _physics_process(delta: float) -> void:
	if score.total_time >= 120.0:
		won = true
		_on_game_over("win")
signal skip
func _on_game_over(cause):
	if won:
		emit_signal("win")
		yield(get_tree().create_timer(3.0),"timeout")
		print("WIN")
		get_tree().call_deferred("quit", WIN)
	else:
		emit_signal("loss", cause)
		var timer = get_tree().create_timer(5.0)
		yield(get_tree().create_timer(1.5),"timeout")
		connect("skip",timer,"emit_signal",["timeout"])
		yield(timer,"timeout")
		print("LOSE")
		get_tree().call_deferred("quit", LOSE)

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.scancode == KEY_ESCAPE and event.is_pressed():
		get_tree().call_deferred("quit",QUIT)
func _unhandled_input(event):
	if event.is_action_pressed("A"):
		emit_signal("skip")
