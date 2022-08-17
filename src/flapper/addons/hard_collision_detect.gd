extends Node


func _on_hard_collision(prev_vel, _post_vel):
	_on_hard_collision_no_args()
func _on_hard_collision_no_args():
	owner.die()
