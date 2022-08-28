extends Node2D


var target
onready var shooter = $shooter

export var predict = false

func _ready():
	target = Group.get_one("flapper")
		
func aim_at(target):
	if is_instance_valid(target):
		var target_position = target.global_position if !predict else predict_target_position(target)
		if target_position:
			global_rotation = target_position.angle_to_point(global_position)

func predict_target_position(target):
	return Aiming.intercept(global_position, target.global_position, target.velocity, shooter.shoot_speed)
