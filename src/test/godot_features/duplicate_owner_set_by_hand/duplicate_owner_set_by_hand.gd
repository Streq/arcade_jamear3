extends Node2D

onready var a = $A
onready var b = $B


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(a.duplicate())
	add_child(b.duplicate())
	
	remove_child(b)
	a.add_child(b)
	b.owner = a
	
	var coso = a.duplicate()
	add_child(coso)
