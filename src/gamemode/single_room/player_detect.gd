extends Area2D

func _ready() -> void:
	set_physics_process(false)
	yield(self,"body_entered")
	set_physics_process(true)
	

func _physics_process(delta: float) -> void:
	if get_overlapping_bodies().empty():
		queue_free()
