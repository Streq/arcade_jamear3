extends Area2D


export var knockback := 2.0

func apply_knockback(on):
	on.velocity += get_knockback(on)
func get_knockback(target):
	return get_parent().velocity*knockback

func register_hit(area):
	area.take_knockback(get_knockback(area.owner))
	area.take_damage(get_damage(area.owner))

func can_hit(area):
	return true
func get_damage(target):
	return 1.0

func _on_hitbox_area_entered(area: Area2D) -> void:
	area._on_area_entered(self)
