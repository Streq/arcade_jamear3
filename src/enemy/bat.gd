extends KinematicBody2D
signal soft_collision(prev_velocity, velocity)
signal hard_collision(prev_velocity, velocity)
signal dead


var target = null
var velocity = Vector2()
export var speed = 100.0
export var air_friction = 1.0
export var soft_collision_threshold = 100.0
export var hard_collision_threshold = 500.0
export var difficulty = 0.0

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

var dir := Vector2()

func  _physics_process(delta):
	if get_tree().has_group("flapper"):
		target = Group.get_one("flapper")
	if is_instance_valid(target) and target.is_inside_tree():
		velocity += dir*speed*delta
		dir = global_position.direction_to(target.global_position)
	else:
		_ready()
		
	var prev_velocity = velocity
	velocity = move_and_slide(velocity)
	var squared_velocity_dt = prev_velocity.length_squared()-velocity.length_squared()
#	print(squared_velocity_dt)
	if squared_velocity_dt > hard_collision_threshold*hard_collision_threshold:
		_on_hard_collision(prev_velocity, velocity)
	elif squared_velocity_dt > soft_collision_threshold*soft_collision_threshold:
		_on_soft_collision(prev_velocity, velocity)

	velocity *= (1.0-delta*air_friction)
	
	
func die():
	emit_signal("dead")
	queue_free()

func _on_hard_collision(prev_velocity, velocity):
	die()
	emit_signal("hard_collision", prev_velocity, velocity)
func _on_soft_collision(prev_velocity, velocity):
	emit_signal("soft_collision", prev_velocity, velocity)

func _ready():
	target = Group.get_one("flapper")
