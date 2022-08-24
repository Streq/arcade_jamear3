extends CanvasLayer

var board = [{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},
{"score":0.0,"name":"________"},]

func load_board():
	pass
func save_board():
	pass

func _ready():
	load_board()

func save_score(name, score):
	board.append({"name":name, "score":score})
	board.sort_custom(self,"_compare_scores")
	if board.size()>10:
		board = board.slice(0,9)
	save_board()
	pass
	
func _compare_scores(a, b):
	return a.score > b.score
