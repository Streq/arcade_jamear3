extends Node


func _on_hard_collision(prev_vel, _post_vel):
	owner.die()
