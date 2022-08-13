extends State

onready var ground_effect_detect = $"%ground_effect_detect"

func _enter(params):
	owner.state_animation.play("glide")
	failing = false
	pass

var failing = false
func _physics_update(delta):
	var vel :Vector2 = owner.velocity
	var normal :Vector2 = owner.direction
	var projected :Vector2 = vel.project(normal)

	owner.state_animation.play("glide")
	if normal.dot(vel) < 0.0:
#		print("vel:",vel,", normal:",normal,", projected:",projected)
		var lift = projected*projected.length()
		
		var ground = ground_effect_detect.get_overlapping_bodies()
		if ground.size()>0:
			print("overlap")
			lift *= 20.0
		
		var interfriction = -1.0
		var break_speed = owner.glide_break_threshold
		var recovery_speed = owner.glide_break_recovery_threshold
		var speed = projected.length()
		if speed > break_speed:
			failing = true
		elif speed < recovery_speed:
			failing = false
		elif failing: #how close am I to glide_break_recovery from 0 to 1
			interfriction = (
				( speed - recovery_speed)
				/
				(break_speed - recovery_speed)
			)
		
		var broken_glide = owner.broken_glide_friction
		var glide = owner.glide_friction
		if failing:
			var fric
			if interfriction < 0.0:
				fric = broken_glide
			else:
				fric = lerp(broken_glide, glide, interfriction)
			owner.state_animation.play("glide_fail")
			owner.velocity -= lift*fric*delta
		else:
			owner.velocity -= lift*glide*delta
	
		
	elif projected.length()>owner.glide_opposite_break_threshold:
		owner.state_animation.play("glide_opposite_fail")
		
	if !Input.is_action_pressed("B"):
		goto("close_wings")
	if Input.is_action_just_pressed("A"):
		goto("glide_flap")
