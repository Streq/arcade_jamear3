extends KinematicBody2D


export var gravity = 200.0


var velocity = Vector2()
var direction = Vector2.UP
onready var state_machine = $state_machine
onready var state_animation = $"%state_animation"
onready var sprite = $Sprite

func _ready():
	state_machine.initialize()

func _physics_process(delta):
	var change_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if change_direction:
		direction = change_direction
	sprite.rotation = -direction.angle_to(Vector2.UP)
	state_machine.physics_update(delta)
	velocity += Vector2.DOWN*gravity*delta
#	velocity *= 0.99
	
	velocity = move_and_slide(velocity)
