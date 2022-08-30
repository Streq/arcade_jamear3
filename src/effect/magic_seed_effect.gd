extends Node
onready var palette = $palette
onready var hitbox = $hitbox

var original_hard_collision_threshold = 0.0
var original_soft_collision_threshold = 0.0
onready var energy_bar = $energy_bar
onready var timer = $Timer

func _ready():
	call_deferred("trigger")
	
func trigger():
	var parent = get_parent()
#	if !parent.sprite:
#		yield(parent,"ready")
	
	original_hard_collision_threshold = parent.hard_collision_threshold
	original_soft_collision_threshold = parent.soft_collision_threshold

	parent.sprite.material = palette.material
	palette.update_parent_material()
	parent.hurtbox.monitorable = false
	parent.hurtbox.monitoring = false
	parent.hard_collision_threshold = 1000000.0
#	parent.soft_collision_threshold = 1000000.0
	remove_child(hitbox)
	parent.add_child(hitbox)
	hitbox.owner = parent
	pass

func _physics_process(delta):
	var parent = get_parent()
	var energy = parent.get_node("energy")
	energy.value = energy.max_value
	energy_bar.ratio = timer.time_left/timer.wait_time
func wear_off():
	var parent = get_parent()
#	if !parent.sprite:
#		yield(parent,"ready")
	parent.sprite.material = parent.material
	parent.palette.update_parent_material()
	parent.hurtbox.monitorable = true
	parent.hurtbox.monitoring = true
	parent.hard_collision_threshold = original_hard_collision_threshold
	parent.soft_collision_threshold = original_soft_collision_threshold
	hitbox.queue_free()
	queue_free()


func _on_Timer_timeout():
	call_deferred("wear_off")
