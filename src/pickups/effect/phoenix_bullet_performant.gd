extends Node2D
signal hit_wall

var velocity := Vector2()
export var drag := 1.0
export var acceleration := 1000.0
export var time := 0.25
export var added_time_random := 0.1

onready var hitbox = $hitbox
onready var col_box = $hitbox/CollisionShape2D
onready var timer: Timer = $Timer

var index = 0

var disappear_on_screen_exit = false
func _physics_process(delta):
	global_position += velocity*delta
	velocity *= (1-delta*drag)
	rotation = velocity.angle() 
	velocity.y -= delta*acceleration
	
#	check_collisions()
#
#func check_collisions():
#	Physics2DShapeQueryParameters.new()
#	pass
	


func _on_area_entered(area):
	disable()


func disable():
	get_parent().unused_bullets.push_back(index)
	col_box.call_deferred("set_disabled",true)
	visible = false
	set_physics_process(false)
	
func enable():
	col_box.call_deferred("set_disabled",false)
	visible = true
	set_physics_process(true)
	timer.start(time+randf()*added_time_random)
