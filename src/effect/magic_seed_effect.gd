extends Node

export var original_hard_collision_threshold = 0.0
export var original_soft_collision_threshold = 0.0

onready var palette = $palette
export var HITBOX :PackedScene

onready var energy_bar = $display_bar/energy_bar
onready var display_bar = $display_bar

onready var timer = $Timer

var wearer = null
export var wait_time = 13.0

export var increase_on_seed = 2.5

func _ready():
	timer.start(wait_time)
	palette.update_parent_material()
	wearer = get_parent()
	
func trigger():
	var parent = get_parent()
	if parent.addons.has("magic_seed"):
		parent.addons.magic_seed.wear_off()
		yield(get_tree(),"idle_frame")
	parent.addons.magic_seed = self
	original_hard_collision_threshold = parent.hard_collision_threshold
	original_soft_collision_threshold = parent.soft_collision_threshold

	parent.sprite.material = palette.material
	palette.update_parent_material()
	parent.hurtbox.monitorable = false
	parent.hurtbox.monitoring = false
	parent.hard_collision_threshold = 1000000.0
	parent.soft_collision_threshold = 1000000.0
	var hitbox = HITBOX.instance()
	parent.add_child(hitbox)
	hitbox.owner = parent
	connect("tree_exited",hitbox,"queue_free",[],CONNECT_PERSIST)
	parent.turbo_flap = true
	parent.connect("seed_taken",self,"_on_seed_taken")
	pass

func _on_seed_taken():
	timer.start(min(wait_time, timer.time_left+increase_on_seed))

func _physics_process(delta):
	var parent = get_parent()
	var energy = parent.get_node("energy")
	energy.value = energy.max_value
	energy_bar.ratio = timer.time_left/wait_time
	
	
func wear_off():
	var parent = get_parent()
	parent.addons.erase("magic_seed")
#	if !parent.sprite:
#		yield(parent,"ready")
	parent.sprite.material = parent.material
	parent.palette.update_parent_material()
	parent.hurtbox.monitorable = true
	parent.hurtbox.monitoring = true
	parent.hard_collision_threshold = original_hard_collision_threshold
	parent.soft_collision_threshold = original_soft_collision_threshold
#	hitbox.queue_free()
	
	parent.turbo_flap = false
	display_bar.queue_free()
	queue_free()


func _on_Timer_timeout():
	call_deferred("wear_off")
