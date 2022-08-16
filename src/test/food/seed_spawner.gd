extends Node2D

signal seed_taken

export var SEED : PackedScene
onready var spawn_area = $spawn_area

var _seed = null


func spawn():
	var point = GeometryUtils.random_point_in_polygon(spawn_area.polygon) + spawn_area.position
	_seed = SEED.instance()
	call_deferred("add_child",_seed)
	_seed.position = point
	_seed.connect("tree_exited", self, "_seed_taken")

func _seed_taken():
	emit_signal("seed_taken")
	spawn()

func _ready():
	yield(get_tree(),"idle_frame")
	spawn()
#func _input(event):
#	if event.is_action_pressed("A"):
#		spawn()
