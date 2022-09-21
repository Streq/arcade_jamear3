extends Node
class_name InputState
var A := ButtonState.new()
var B := ButtonState.new()
var dir := Vector2()


func _physics_process(delta: float) -> void:
	A.just_updated = false
	B.just_updated = false


func set_A(val:bool):
	A.pressed = val
func set_B(val:bool):
	B.pressed = val
func set_dir(val:Vector2):
	dir = val
	
