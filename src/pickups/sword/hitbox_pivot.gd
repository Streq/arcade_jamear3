extends Node2D

var hits = []

func _ready():
	for child in get_children():
		child.connect("hit",self,"_on_hit")

func _on_hit(area):
	hits.append(area.owner)
	
func _physics_process(delta):
	hits.clear()
