extends Node

export var original_hard_collision_threshold = 0.0
export var original_soft_collision_threshold = 0.0

onready var palette = $palette
export var HITBOX :PackedScene

onready var energy_bar = $energy_bar
onready var timer = $Timer


export var wait_time = 13.0

export var increase_on_seed = 2.5

func _ready():
	timer.start(wait_time)
	palette.update_parent_material()
	
	
func trigger():
	var parent = get_parent()


func _on_seed_taken():
	timer.start(min(wait_time, timer.time_left+increase_on_seed))

func _physics_process(delta):
	var parent = get_parent()
	var energy = parent.get_node("energy")
	energy.value = energy.max_value
	energy_bar.ratio = timer.time_left/wait_time
func wear_off():
	queue_free()


func _on_Timer_timeout():
	call_deferred("wear_off")
