extends Node2D

export var SCENE_A : PackedScene
export var SCENE_B : PackedScene

onready var a = SCENE_A.instance()
onready var b = SCENE_B.instance()

var current = null
onready var viewporta = $Viewport
onready var viewportb = $Viewport2
onready var texture_rect = $CanvasLayer/TextureRect
onready var vp_tex : ViewportTexture = texture_rect.texture
onready var root = get_tree().root


func _ready():
	current = viewporta
	yield(get_tree().root, "ready")
	viewporta.add_child(a)
	viewportb.add_child(b)
	

func _input(event):
	if event.is_action_pressed("A"):
		if current == a:
			vp_tex.viewport_path = viewporta.get_path()
			current = b
			
		else:
			vp_tex.viewport_path = viewportb.get_path()
			current = a
		
