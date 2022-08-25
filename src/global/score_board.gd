extends CanvasLayer

var board = [{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},
{"score":0.0,"name":""},]

export var board_size = 10


const SAVE_PATH := "user://save.res"


func save_board():
	var save = File.new()
	save.open(SAVE_PATH, File.WRITE)
	save.store_var(board)
	save.close()
func load_board():
	var save = File.new()
	if save.open(SAVE_PATH, File.READ) == OK:
		var invalid = false
		var saved_board = save.get_var()
		if saved_board is Array:
			var arr := saved_board as Array
			for entry in arr:
				if !("score" in entry) or !("name" in entry):
					invalid = true
					break
		else:
			invalid = true
		if invalid:
			printerr("invalid save: ", to_json(saved_board))
		else:
			board = saved_board
		

func _ready():
	load_board()

func save_score(name, score):
	board.append({"name":name, "score":score})
	board.sort_custom(self,"_compare_scores")
	if board.size()>board_size:
		board = board.slice(0,board_size-1)
	save_board()
	pass
	
func _compare_scores(a, b):
	return a.score > b.score

func is_new_record(score):
	return board.size() < board_size or board[board_size-1].score < score
