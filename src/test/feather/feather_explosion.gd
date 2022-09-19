extends Node2D


export var FEATHER : PackedScene

onready var label = $"../CanvasLayer/Label"

func _ready():
	yield(get_tree(),"idle_frame")

var mouse_delta = Vector2()
var old_mouse_pos = Vector2()
func _physics_process(delta):
	var new_mouse_pos = get_local_mouse_position()
	mouse_delta = new_mouse_pos-old_mouse_pos
	old_mouse_pos = new_mouse_pos
#	print(mouse_delta)
	label.text = str(get_child_count())
	if Input.is_action_pressed("B"):
		explode()
	
func _input(event):
	if event.is_action_pressed("A"):
		explode()
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()
		
func explode():
	for i in 10:
		var instance = FEATHER.instance()
		add_child(instance)
		instance.rotation = randf()*TAU
		instance.velocity = Vector2.LEFT.rotated(randf()*TAU)*300
		instance.position = get_local_mouse_position()
		instance.velocity += mouse_delta*20
		
