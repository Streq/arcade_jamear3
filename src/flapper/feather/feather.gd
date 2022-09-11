extends Node2D

onready var sprite = $Sprite

export var gravity := 100.0
export var friction := 10.0
export var velocity := Vector2()
onready var visibility_notifier_2d = $VisibilityNotifier2D
const MAX_FEATHERS = 200

var angular_inertia := 0.0

func _ready():
	var feathers : Array = Group.get_all("feather")
	if feathers.size() > MAX_FEATHERS:
#		for i in range(0, feathers.size()-MAX_FEATHERS):
#			feathers[i].queue_free()
#		queue_free()
		pass
	

func _physics_process(delta):
	global_position += velocity*delta
	velocity.y += gravity*delta
	var projected_vel = velocity.project(Vector2.UP.rotated(rotation))
	
	velocity -= projected_vel*friction*delta
	var normal = Vector2.DOWN.rotated(rotation)
	
	angular_inertia += normal.angle_to(velocity)*delta*0.1*velocity.length()
	angular_inertia *= (1.0-delta)
	rotation += angular_inertia*delta
	
	
	
	velocity *= (1.0 - delta*2)
	

func _on_screen_exited():
	queue_free()


func _on_spawn_timer_timeout():
	if !visibility_notifier_2d.is_on_screen():
		queue_free()
