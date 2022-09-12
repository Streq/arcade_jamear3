extends Node

func _on_area_entered(area):
	owner.queue_free()
