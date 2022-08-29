extends KinematicBody2D


var target = null
var velocity = Vector2()

export var speed = 100.0
export var air_friction = 1.0

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer


export var facing_right := true
func turn_around():
	set_facing_right(!facing_right)
func set_facing_right(val):
	facing_right = val
	if facing_right:
		sprite.scale.x = 1.0
	else:
		sprite.scale.x = -1.0

func get_facing_dir():
	return Bool.sign(!facing_right)


func  _physics_process(delta):
	
	if is_instance_valid(target):
		var dir = global_position.direction_to(target.global_position)
		velocity += dir*speed*delta
		if sign(dir.x)!=get_facing_dir():
			animation_player.play("turn")
		elif !animation_player.is_playing():
			animation_player.play("floating")
	else:
		_ready()
	velocity = move_and_slide(velocity)
	velocity *= (1.0-delta*air_friction)
	
	
	
	
func _ready():
	target = Group.get_one("flapper")
