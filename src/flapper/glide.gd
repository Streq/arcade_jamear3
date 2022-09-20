extends State

onready var ground_effect_detect = $"%ground_effect_detect"

signal failing_from_below(normal_force)
signal failing_from_above(normal_force)
signal glide_pressure(normal_force)
signal glide_tangent(tangent_speed)


func _enter(params):
	owner.state_animation.play("glide")
	failing_up = false
	failing_down = false
	pass

enum {
	GLIDE,
	GLIDE_BACK,
	FAILING,
	FAILING_BACK
}
var state = GLIDE

var failing_up = false
var failing_down = false
func _physics_update(delta):
	var velocity :Vector2 = owner.velocity
	var normal :Vector2 = owner.direction
	var projected :Vector2 = velocity.project(normal)
	var projected_length = projected.length()
	
	var lift_is_below_wings = normal.dot(velocity) < 0.0
#	if lift_is_below_wings:
	emit_signal("glide_pressure", projected_length)
	owner.state_animation.play("glide")
	var lift_vec = projected*projected_length
	var lift = projected.length_squared()
	if lift_is_below_wings:
		var max_force_wings_can_handle = owner.glide_break_threshold
		var max_force_bent_wings_can_recover_from = owner.glide_break_recovery_threshold
		var broken_friction = owner.broken_glide_friction
		var friction = owner.glide_friction
		var normal_force = projected_length
		if normal_force > max_force_wings_can_handle:
			failing_up = true
		elif normal_force <= max_force_bent_wings_can_recover_from:
			failing_up = false
			
		if failing_up:
			owner.state_animation.play("glide_fail")
			owner.velocity -= lift_vec*broken_friction*delta
			
			emit_signal("failing_from_below", projected_length)
#			print(owner.velocity)
#			print(projected)
		else:
			owner.velocity -= lift_vec*friction*delta
	
		
	else: #lift is above wings
		var max_force_wings_can_handle = owner.glide_opposite_break_threshold
		var max_force_bent_wings_can_recover_from = owner.glide_opposite_break_recovery_threshold
		var normal_force = projected_length
		var broken_friction = owner.broken_glide_opposite_friction
		var friction = owner.glide_opposite_friction
		if normal_force > max_force_wings_can_handle:
			failing_down = true
		elif normal_force <= max_force_bent_wings_can_recover_from:
			failing_down = false
			
		if failing_down:
			owner.state_animation.play("glide_opposite_fail")
			owner.velocity -= lift_vec*broken_friction*delta
			emit_signal("failing_from_above", projected_length)
			
#			print(owner.velocity)
#			print(projected)
		else:
			owner.velocity -= lift_vec*friction*delta
	
	var tangent = Vector2(normal.y,-normal.x)
	emit_signal("glide_tangent", owner.velocity.project(tangent).length())
	
	if !owner.input_state.B.is_pressed():
		goto("close_wings")
	if owner.input_state.A.is_just_pressed():
		goto("glide_flap")
