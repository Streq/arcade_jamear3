extends KinematicBody2D


export var gravity = 200.0
export var air_friction = 0.0


var velocity = Vector2()
var direction := Vector2.UP
onready var state_machine = $state_machine
onready var state_animation = $"%state_animation"
onready var sprite = $Sprite

func _ready():
	state_machine.initialize()

func _physics_process(delta):
	var change_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if change_direction:
#		direction = change_direction
		direction = Vector2.RIGHT.rotated(lerp_angle(direction.angle(),change_direction.angle(),delta*4.0))
	
	var point_dir = -direction.angle_to(Vector2.UP)
	sprite.rotation = point_dir
#	sprite.rotation = stepify(point_dir,PI/8.0)
#	print("point_dir:",point_dir," stepify:",stepify(point_dir,PI/8.0))
	state_machine.physics_update(delta)
	velocity += Vector2.DOWN*gravity*delta
	
	#air_friction = velocity*velocity*k
	var air_friction_force = velocity.length()*air_friction
	velocity *= (1-air_friction_force*delta)
	velocity = move_and_slide(velocity)
	if velocity:
		print(velocity)
	
