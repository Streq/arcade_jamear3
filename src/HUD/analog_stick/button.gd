extends Node2D
onready var animation_player: AnimationPlayer = $AnimationPlayer
var pressed = false
func update_input(val:bool)->void:
	if val != pressed:
		if val:
			animation_player.play("pressed")
		else:
			animation_player.play("unpressed")
	pressed = val
	

func __unhandled_input(event: InputEvent) -> void:
	if event.is_action("A"):
		update_input(event.is_pressed())
