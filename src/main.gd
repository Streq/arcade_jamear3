extends Node2D

func _ready():
	var output = []
	var exit_code = OS.execute("./is_executable.sh", ["./exports/playjam/pajarito_linux_playjam/lmao"], true, output)
	print(output)
