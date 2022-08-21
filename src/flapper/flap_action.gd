extends Node

func trigger(speed):
	owner.velocity += speed*owner.direction

func weak():
	owner.velocity += owner.weak_flap*owner.direction
	owner.emit_signal("flapped")

func strong():
	owner.velocity += owner.strong_flap*owner.direction
	owner.emit_signal("flapped")

func weak_failed():
	owner.velocity += owner.failed_weak_flap*owner.direction
	owner.emit_signal("failed_flap")

func strong_failed():
	owner.velocity += owner.failed_strong_flap*owner.direction
	owner.emit_signal("failed_flap")
