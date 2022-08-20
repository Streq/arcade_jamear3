extends Area2D

export var amount := 1000.0



func _on_area_entered(area):
	var flapper = area.get_parent()
	if flapper.addons.has("energy"):
		var energy = flapper.addons["energy"]
		energy.set_value(energy.value+amount)
		queue_free()
