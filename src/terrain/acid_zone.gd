extends Area2D

func _ready():
	connect("area_entered",self,"_on_acid_zone_area_entered")

func _on_acid_zone_area_entered(area):
	area.emit_signal("area_entered",self)
	
