extends Node2D
onready var grabbed = $grabbed
onready var grab_zone : Area2D = $grab_zone
onready var current = grabbed.get_child(0) if grabbed.get_child_count() != 0 else null

signal drop()
signal grab()

func trigger():
#	print("grab_attempt")
	if is_instance_valid(current):
		drop()
	else:
		attempt_grab()


func drop():
	var environment = get_parent().owner.get_parent()
	NodeUtils.reparent_keep_transform(current, environment)
	current.velocity = get_parent().owner.velocity
	current = null
	emit_signal("drop")
	
	
func attempt_grab():
	for area in grab_zone.get_overlapping_areas():
		if !area.grabbed:
			area.grabbed = true
			connect("drop", area,"_on_drop",[self])
			NodeUtils.reparent(area.get_parent(), grabbed)
			area.get_parent().position = Vector2.ZERO
			current = area.get_parent()
			emit_signal("grab", area.get_parent())
			area._on_grab(self)
			return
	pass
