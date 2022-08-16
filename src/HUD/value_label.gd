extends Label
export var stat := ""


func set_value(val):
	text = "%s:%s" % [stat, str(val)]
