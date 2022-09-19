extends Node2D
onready var analog_stick: Node2D = $analog_stick
onready var A: Node2D = $A
onready var B: Node2D = $B


func feed_state(dir:Vector2, a:bool, b:bool) -> void:
	analog_stick.update_position(dir)
	A.update_input(a)
	B.update_input(b)
	
