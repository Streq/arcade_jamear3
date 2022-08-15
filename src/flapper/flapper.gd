extends KinematicBody2D

signal flapped

export var gravity := 200.0
export var air_friction := 0.0
export (float, 0.0, 60.0) var rotation_lerp := 4.0
export var strong_flap := 175.0
export var weak_flap := 125.0
export var failed_strong_flap := 50.0
export var failed_weak_flap := 50.0
export var glide_break_threshold := 200.0
export var glide_break_recovery_threshold := 100.0
export var glide_opposite_break_threshold := 100.0
export var glide_opposite_break_recovery_threshold := 75.0
export var glide_friction := 1.0
export var broken_glide_friction := 0.01
export var glide_opposite_friction := 1.0
export var broken_glide_opposite_friction := 0.01

export var animation_speed_multiplier := 1.0 setget set_animation_speed
export var custom_animation_lengths := {} setget set_custom_animation_lengths

var can_flap = true

var addons = {}

var ready = false
func set_custom_animation_lengths(val):
	custom_animation_lengths = val
	if ready:
		animation_scaler.update_lengths()


func set_animation_speed(val):
	animation_speed_multiplier = val
	if state_animation:
		state_animation.playback_speed = val



var velocity = Vector2()
var direction := Vector2.UP
onready var state_machine := $state_machine
onready var state_animation := $"%state_animation"
onready var sprite = $Sprite
onready var animation_scaler = $"%animation_scaler"

func _ready():
	state_machine.initialize()
	set_animation_speed(animation_speed_multiplier)
	ready = true
func _physics_process(delta):
	var change_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if change_direction:
#		direction = change_direction
		direction = Vector2.RIGHT.rotated(lerp_angle(direction.angle(),change_direction.angle(),delta*rotation_lerp))
	
	var point_dir = -direction.angle_to(Vector2.UP)
	sprite.rotation = point_dir
#	sprite.rotation = stepify(point_dir,PI/8.0)
#	print("point_dir:",point_dir," stepify:",stepify(point_dir,PI/8.0))
	state_machine.physics_update(delta)
	velocity += Vector2.DOWN*gravity*delta
	
	#air_friction = velocity*velocity*k
		
#	var air_friction_force = velocity.length()*air_friction
#	velocity *= (1-air_friction_force*delta)
	var air_resistance = get_air_resistance()
	velocity = velocity.move_toward(Vector2.ZERO, air_resistance*delta)
	
	velocity = move_and_slide(velocity)
#	if velocity:
#		print(velocity)
	

func get_air_resistance():
	#Air resistance can be calculated by 
	#taking air density times the drag coefficient
	#times area all over two, 
	#and then multiply by velocity squared.
#	var air_density = 1.0
	var drag_coefficient = air_friction
#	var area = 1.0 
	var air_resistance = (drag_coefficient)*velocity.length_squared()
	return air_resistance
