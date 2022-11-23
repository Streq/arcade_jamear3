extends Sprite

export var speed = 200.0
var node_position = null


enum STATE {
	IDLE,
	MOVING
}

var state : int
func _input(event):
	if state == STATE.IDLE:
		if event.is_action("ui_left"):
			move_to(node_position.node_left)
		if event.is_action("ui_right"):
			move_to(node_position.node_right)
		if event.is_action("ui_up"):
			move_to(node_position.node_up)
		if event.is_action("ui_down"):
			move_to(node_position.node_down)

func move_to(node):
	if !is_instance_valid(node):
		return
	state = STATE.MOVING
	var from = self.global_position
	var to = node.global_position
	var tween = create_tween()
	tween.tween_property(self,"global_position",to,(from.distance_to(to))/200.0)
	yield(tween,"finished")
	node_position = node
	state = STATE.IDLE
