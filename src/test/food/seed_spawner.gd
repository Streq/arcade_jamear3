extends Node2D

signal seed_taken
signal requirement_met

export var SEED : PackedScene
export var required_seeds := 3
export var current_seeds := 0
onready var spawn_area = $spawn_area

var _seed = null


func spawn():
	if is_inside_tree():
		var point = spawn_area.get_random_point()
		_seed = SEED.instance()
		_seed.connect("tree_exited", self, "_seed_taken")
		yield(get_tree(),"idle_frame")
		get_tree().current_scene.add_child(_seed)
		_seed.global_position = point
		

func _seed_taken():
	emit_signal("seed_taken")
	current_seeds += 1
	if current_seeds == required_seeds:
		emit_signal("requirement_met")
	spawn()

func _ready():
	yield(get_tree(),"idle_frame")
	spawn()
#func _input(event):
#	if event.is_action_pressed("A"):
#		spawn()
