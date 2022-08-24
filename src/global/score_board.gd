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


func load_board():
	pass
func save_board():
	pass

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
