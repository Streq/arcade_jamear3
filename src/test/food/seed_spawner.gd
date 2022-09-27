extends Node2D

signal seed_taken
signal requirement_met

export var SEED : PackedScene
export var PORTAL : PackedScene
export var required_seeds := 3
export var current_seeds := 0
onready var spawn_area = $spawn_area

var _seed = null


func spawn():
	if is_inside_tree():
		var point = spawn_area.get_random_point()
		_seed = SEED.instance()
		_seed.connect("tree_exiting", self, "_seed_taken")
		yield(get_tree(),"idle_frame")
		get_parent().add_child(_seed)
		_seed.global_position = point
		
func spawn_portal():
	if is_inside_tree():
		var point = spawn_area.get_random_point()
		var portal = PORTAL.instance()
		yield(get_tree(),"idle_frame")
		get_parent().add_child(portal)
		portal.global_position = point
		portal.connect("player_exited",get_parent(),"area_completed")
		
		
func _seed_taken():
	emit_signal("seed_taken")
	current_seeds += 1
#	print(current_seeds)
	if current_seeds == required_seeds:
		emit_signal("requirement_met")
		spawn_portal()
	spawn()

func _ready():
	yield(get_tree(),"idle_frame")
	spawn()
#func _input(event):
#	if event.is_action_pressed("A"):
#		spawn()
