extends KinematicBody2D

signal flapped
signal glide_flapped
signal glide_pre_flap
signal pre_flap
signal failed_flap

signal hard_collision(prev_velocity,post_velocity)
signal soft_collision(prev_velocity,post_velocity)
signal touch_collision(prev_velocity,post_velocity)
signal graze(applied_friction)
signal entered_portal(portal)
signal seed_taken()
signal duplicated(clone)
signal die()
signal killed_by(cause)


export var gravity := 200.0
export var air_friction := 0.0
export var mass := 1.0
export (float, 0.0, 60.0) var rotation_lerp := 4.0
export var strong_flap := 87.0 setget,get_strong_flap
func get_strong_flap():
	return modifiers.map.flap_power.apply(strong_flap)
export var weak_flap := 62.0 setget,get_weak_flap
func get_weak_flap():
	return modifiers.map.flap_power.apply(weak_flap)
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

export var touch_collision_threshold := 50.0
export var soft_collision_threshold := 200.0 setget,get_soft_collision_threshold
func get_soft_collision_threshold():
	return stats.resistance*soft_collision_threshold
export var hard_collision_threshold := 500.0 setget,get_hard_collision_threshold
func get_hard_collision_threshold():
	return stats.resistance*hard_collision_threshold

export var graze_threshold := 10.0
export var delta_multiplier := 1.0 

export var animation_speed_multiplier := 1.0 setget set_animation_speed
export var custom_animation_lengths := {} setget set_custom_animation_lengths

export var turbo_flap = false setget, has_turbo_flap
func has_turbo_flap():
	return turbo_flap

export var bounciness = 0.25
export var friction = 0.1

var can_flap = true

var addons = {}

var ready = false
var dead = false

export var velocity := Vector2() setget set_velocity
export var direction := Vector2.UP
onready var state_machine := $state_machine
onready var state_animation := $"%state_animation"
onready var sprite = $"%Sprite"
onready var animation_scaler = $"%animation_scaler"
onready var palette_manager = $"%Sprite/palette_manager"
onready var hurtbox = $hurtbox
onready var pivot = $pivot
onready var stats = $stats
onready var modifiers = $modifier_map
onready var HUD = $HUD
onready var input_state: Node = $input_state

func set_velocity(val):
#	print_stack()
	velocity = val
	
func set_custom_animation_lengths(val):
	custom_animation_lengths = val
	if ready:
		animation_scaler.update_lengths()


func set_animation_speed(val):
	animation_speed_multiplier = val
	if state_animation:
		state_animation.playback_speed = val

func _on_seed_taken():
	emit_signal("seed_taken")


func _ready():
	state_machine.initialize()
	set_animation_speed(animation_speed_multiplier)
	ready = true
#	Global._player_is_alive()
#	connect("die", Global, "_player_died")

func _physics_process(delta):
	delta *= delta_multiplier
	var change_direction = input_state.dir
	if change_direction.length_squared()>0.01:
		direction = Vector2.RIGHT.rotated(lerp_angle(direction.angle(),change_direction.angle(),delta*rotation_lerp))
	var point_dir = -direction.angle_to(Vector2.UP)
	pivot.rotation = point_dir
#	sprite.rotation = stepify(point_dir,PI/8.0)
#	print("point_dir:",point_dir," stepify:",stepify(point_dir,PI/8.0))
	state_machine.physics_update(delta)
	velocity += Vector2.DOWN*gravity*delta
	
	#air_friction = velocity*velocity*k
		
#	var air_friction_force = velocity.length()*air_friction
#	velocity *= (1-air_friction_force*delta)
	var air_resistance = get_air_resistance()
	velocity = velocity.move_toward(Vector2.ZERO, air_resistance*delta)
	
	var prev_velocity = velocity
	var new_velocity = move_and_slide(velocity)
	
	var squared_velocity_dt = prev_velocity.length_squared()-new_velocity.length_squared()
#	print(squared_velocity_dt)
	
	var slides = get_slide_count()
	if slides:
		if squared_velocity_dt > hard_collision_threshold*hard_collision_threshold:
			emit_signal("hard_collision", prev_velocity, new_velocity)
		elif squared_velocity_dt > soft_collision_threshold*soft_collision_threshold:
			emit_signal("soft_collision", prev_velocity, new_velocity)
		elif squared_velocity_dt > touch_collision_threshold*touch_collision_threshold:
			emit_signal("touch_collision", prev_velocity, new_velocity)
			
		var collision = get_slide_collision(0)
		var normal = collision.normal
		
		velocity -= velocity.project(normal)*(1.0-bounciness)
		velocity = velocity.bounce(normal)
		
		var tangent = Vector2(normal.y, -normal.x)
		var applied_friction = velocity.project(tangent)*friction
		if applied_friction.length_squared() > graze_threshold*graze_threshold:
			emit_signal("graze", applied_friction.length_squared())
		velocity -= applied_friction
		
	else:
		velocity = new_velocity
	

func die(cause := ""):
	if dead:
		return
	visible = false
	set_physics_process(false)
	dead = true
	emit_signal("die")
	emit_signal("killed_by",cause)
	remove_from_group("flapper")
	if has_node("camera"):
		NodeUtils.reparent_keep_transform(get_node("camera"),get_parent())
	
	pivot.queue_free()
	yield(get_tree().create_timer(3.0),"timeout")
	queue_free()
		

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


