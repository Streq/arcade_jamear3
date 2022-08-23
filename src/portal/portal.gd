extends Node2D

var state = 0
onready var state_change = $state_change
onready var hum = $"hum"
onready var texture_rect = $Viewport/TextureRect


func _ready():
	state_change.play("open")
	state_change.queue("hum")
	texture_rect.texture = Levels.get_next_level().texture
	Global.portal_open()

func _on_exited():
	state_change.play("close")
	yield(state_change,"animation_finished")
#	yield(get_tree().create_timer(1.0),"timeout")
	Levels.next_level()
