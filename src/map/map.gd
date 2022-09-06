extends Node
signal area_completed


func area_completed():
	emit_signal("area_completed")


func _on_acid_zone_area_entered(area):
	area.owner.die()
