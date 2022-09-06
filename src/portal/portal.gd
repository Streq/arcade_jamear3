extends Node2D

signal player_exited

var state = 0
onready var state_change = $state_change
onready var texture_rect = $Viewport/TextureRect

func _ready():
	var circuit = Group.get_one("level_circuit")
	if circuit:
		set_background(circuit.get_next_level().texture)
	
	state_change.play("open")
	state_change.queue("hum")
#	texture_rect.texture = Levels.get_next_level().texture

func set_background(texture):
	texture_rect.texture = texture

var player_dead = false
func _on_player_dead():
	player_dead = true
	
func _on_exited():
	state_change.play("close")
	yield(state_change,"animation_finished")
#	yield(get_tree().create_timer(1.0),"timeout")
	if !player_dead:
#		Levels.next_level()
		emit_signal("player_exited")
