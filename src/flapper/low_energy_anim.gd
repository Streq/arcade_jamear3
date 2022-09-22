extends AnimationPlayer


func _ready() -> void:
	get_parent().connect("value_changed",self,"_on_value_changed")

func _on_value_changed(val):
	if val/get_parent().max_value < 0.4:
		play("low")
	else:
		play("RESET")
