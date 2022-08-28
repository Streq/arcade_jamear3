extends Area2D

signal heard(target)
signal heard_second_hand(target)

var on_the_loop_about = {}

func _on_flapped(who):
	if !on_the_loop_about.has(who) or !on_the_loop_about[who]:
		on_the_loop_about[who] = true
		emit_signal("heard", who)


func _on_hearing_body_entered(body):
	body.connect("flapped", self, "_on_flapped", [body])

func _on_hearing_body_exited(body):
	if body.is_connected("flapped", self, "_on_flapped"):
		body.disconnect("flapped", self, "_on_flapped")

func _physics_process(delta):
	for key in on_the_loop_about:
		on_the_loop_about[key] = false
	update()
func _draw():
	var col = Color.yellow if owner.state_machine.current.name == "asleep" else Color.red
	draw_arc(Vector2(), shape_owner_get_shape(0,0).radius, 0, TAU, 64, col, 1.0, false)
#	draw_circle(Vector2(),shape_owner_get_shape(0,0).radius,Color.red)


func _on_hearing_area_entered(area):
	area.connect("heard",self,"_on_flapped")

func _on_hearing_area_exited(area):
	if area.is_connected("heard", self, "_on_flapped"):
		area.disconnect("heard", self, "_on_flapped")
