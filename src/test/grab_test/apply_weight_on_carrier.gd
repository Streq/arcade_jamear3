extends Node
export var mass := 0.5

var grabber = null

func _physics_process(delta: float) -> void:
	if is_instance_valid(grabber):
		pass
	


func _on_dropped(by) -> void:
	if grabber == by:
		grabber.get_parent().owner.mass -= mass
		grabber = null


func _on_grabbed(by) -> void:
	grabber = by
	var grabber_body = grabber.get_parent().owner
	grabber_body.mass += mass
	grabber_body.velocity = (grabber_body.velocity + get_parent().velocity*mass)/grabber_body.mass
	
