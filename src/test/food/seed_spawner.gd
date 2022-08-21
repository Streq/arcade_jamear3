extends Node2D

signal seed_taken

export var SEED : PackedScene
onready var spawn_area = $spawn_area

var _seed = null


func spawn():
	if is_inside_tree():
		var rand_point = GeometryUtils.random_point_in_polygon(spawn_area.polygon)
#		var point = rand_point
		var point = spawn_area.global_transform.xform(rand_point)
		_seed = SEED.instance()
		_seed.connect("tree_exited", self, "_seed_taken")
		yield(get_tree(),"idle_frame")
		get_tree().current_scene.add_child(_seed)
		_seed.global_position = point
		

func _seed_taken():
	emit_signal("seed_taken")
	spawn()

func _ready():
	yield(get_tree(),"idle_frame")
	spawn()
#func _input(event):
#	if event.is_action_pressed("A"):
#		spawn()
