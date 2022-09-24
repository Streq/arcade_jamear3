extends Area2D

export var knockback := 200.0
export var damage := 1.0
func apply_knockback(on):
	on.velocity += get_knockback(on)
	
func get_knockback(target):
	return owner.velocity.normalized()*knockback
	
func can_hit(area):
	return true


func register_hit(area):
	area.take_knockback(get_knockback(area.owner))
	area.take_damage(get_damage(area.owner))
	
func get_damage(target):
	return damage

func _on_area_entered(area:Area2D):
	area._on_area_entered(self)

func _ready():
	connect("area_entered",self,"_on_area_entered")
