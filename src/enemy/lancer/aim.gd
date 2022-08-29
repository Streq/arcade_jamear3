extends Node2D


var target

onready var shooter = $shooter
export (float, 0.0,1.0) var prediction = 0.0

func _ready():
	target = Group.get_one("flapper")
		
#param target dude to aim at
#param prediction how much to interpolate with the prediction of where the target will be
func aim_at(target):
	if is_instance_valid(target):
		var shoot_at
		if prediction==0.0:
			shoot_at = target.global_position
		else:
			shoot_at = lerp(target.global_position, predict_target_position(target), prediction)
		
		global_rotation = shoot_at.angle_to_point(global_position)

func predict_target_position(target):
	var intercept = Aiming.intercept(global_position, target.global_position, target.velocity, shooter.shoot_speed)
	if intercept == null:
		intercept = Aiming.intercept_flawed(global_position, target.global_position, target.velocity, shooter.shoot_speed)
	return intercept
