extends Node

func trigger(speed):
	owner.velocity += speed*owner.direction

func weak():
	owner.velocity += owner.weak_flap*owner.direction

func strong():
	owner.velocity += owner.strong_flap*owner.direction
