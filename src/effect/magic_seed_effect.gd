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
	trigger()

func pre_ready(wearer):
	self.wearer = wearer

func trigger():
	if !("addons" in wearer):
		yield(wearer,"ready")
	
	if wearer.addons.has("magic_seed"):
		wearer.addons.magic_seed.wear_off()
		yield(get_tree(),"idle_frame")
	wearer.addons.magic_seed = self
	original_hard_collision_threshold = wearer.hard_collision_threshold
	original_soft_collision_threshold = wearer.soft_collision_threshold

	wearer.sprite.material = palette.material
	palette.update_parent_material()
	wearer.hurtbox.monitorable = false
	wearer.hurtbox.monitoring = false
	wearer.hard_collision_threshold = 1000000.0
	wearer.soft_collision_threshold = 1000000.0
	var hitbox = HITBOX.instance()
	wearer.add_child(hitbox)
	hitbox.owner = wearer
	connect("tree_exited",hitbox,"queue_free",[],CONNECT_PERSIST)
	wearer.turbo_flap = true
	wearer.connect("seed_taken",self,"_on_seed_taken")
	pass

func _on_seed_taken():
	timer.start(min(wait_time, timer.time_left+increase_on_seed))

func _physics_process(delta):
	var energy = wearer.get_node("energy")
	energy.value = energy.max_value
	energy_bar.ratio = timer.time_left/wait_time
	
	
func wear_off():
	wearer.addons.erase("magic_seed")
#	if !wearer.sprite:
#		yield(wearer,"ready")
	wearer.sprite.material = wearer.material
	wearer.palette.update_parent_material()
	wearer.hurtbox.monitorable = true
	wearer.hurtbox.monitoring = true
	wearer.hard_collision_threshold = original_hard_collision_threshold
	wearer.soft_collision_threshold = original_soft_collision_threshold
#	hitbox.queue_free()
	
	wearer.turbo_flap = false
	display_bar.queue_free()
	queue_free()


func _on_Timer_timeout():
	call_deferred("wear_off")
