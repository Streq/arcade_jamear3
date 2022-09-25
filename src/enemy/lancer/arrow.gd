extends Node2D
signal hit_wall
signal disable
signal enable


var velocity := Vector2()
onready var hitbox = $hitbox
var index = 0
var disappear_on_screen_exit = false


func _physics_process(delta):
	global_position += velocity*delta
	
func _on_terrain_box_body_entered(body):
	velocity = Vector2()
	hitbox.set_deferred("monitoring", false)
	disappear_on_screen_exit = true
	emit_signal("hit_wall")

var disabled = false
func disable():
	if !disabled:
		disabled = true
		get_parent().unused_bullets.push_back(index)
		visible = false
		set_physics_process(false)
		emit_signal("disable")

func enable():
	disabled = false
	visible = true
	set_physics_process(true)
	emit_signal("enable")

