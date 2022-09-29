extends ViewportContainer


func _ready() -> void:
	yield(get_tree(),"idle_frame")
	if !Engine.editor_hint:
		visible = false
	pass
