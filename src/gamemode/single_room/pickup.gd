extends Area2D
signal picked_up(by)


export var amount := 1000.0

onready var pickup_sound = $pickup_sound

onready var line = $nav_indicator/Line2D



func _on_area_entered(area):
	var flapper = area.get_parent()

	remove_child(pickup_sound)
	get_parent().add_child(pickup_sound)
	
	pickup_sound.global_transform = global_transform
	pickup_sound.connect("finished", pickup_sound, "queue_free")
	pickup_sound.play()
	queue_free()
	
	emit_signal("picked_up", flapper)
		
