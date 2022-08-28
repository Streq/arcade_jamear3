extends Node2D
signal hit_wall

var velocity := Vector2()
onready var hitbox = $hitbox

var disappear_on_screen_exit = false

onready var visibility_notifier_2d = $VisibilityNotifier2D

func _physics_process(delta):
	global_position += velocity*delta
	if disappear_on_screen_exit and !visibility_notifier_2d.is_on_screen():
		queue_free()

func _on_terrain_box_body_entered(body):
	velocity = Vector2()
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	disappear_on_screen_exit = true
	emit_signal("hit_wall")
