extends Sprite

export var speed = 200.0
var node_position = null


enum STATE {
	IDLE,
	MOVING
}

var state : int

var map = {
	"ui_left": Vector2.LEFT,
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_down": Vector2.DOWN
}

func _input(event):
	if state == STATE.IDLE:
		var dir = Vector2.ZERO
		for key in map:
			if event.is_action(key):
				dir = map[key]
				break
		move_to(node_position.get_road_node(dir))
		
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
