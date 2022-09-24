extends Node2D
signal hit_wall

var velocity := Vector2()
onready var hitbox = $hitbox

var disappear_on_screen_exit = false


func _physics_process(delta):
	global_position += velocity*delta
	
func _on_terrain_box_body_entered(body):
	velocity = Vector2()
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	disappear_on_screen_exit = true
	emit_signal("hit_wall")
