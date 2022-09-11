extends Area2D
signal picked_up()


export var amount := 1000.0

onready var pickup_sound = $pickup_sound

onready var line = $nav_indicator/Line2D if has_node("nav_indicator/Line2D") else null



func _on_area_entered(area):
	var flapper = area.get_parent()
	if flapper.addons.has("energy"):
		var energy = flapper.addons["energy"]
		energy.set_value(energy.value+amount)
		
		remove_child(pickup_sound)
		get_parent().add_child(pickup_sound)
		
		pickup_sound.global_transform = global_transform
		pickup_sound.connect("finished", pickup_sound, "queue_free")
		pickup_sound.play()
		queue_free()
		flapper._on_seed_taken()
		
