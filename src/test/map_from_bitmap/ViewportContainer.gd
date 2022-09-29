extends ViewportContainer


func _ready() -> void:
	if !Engine.editor_hint:
		visible = false
	pass
