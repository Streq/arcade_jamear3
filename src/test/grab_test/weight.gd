extends KinematicBody2D

export var velocity := Vector2()

var weight := 200.0

#export var grabbed = false

func  _ready() -> void:
	var parent = get_parent()
	var parent_owner = parent.owner
#	parent_owner.connect("glide_pre_flap",self,"drop",[],CONNECT_ONESHOT)

func drop():
	var parent = get_parent()
	var parent_owner = parent.owner
	var grandpa = parent_owner.get_parent()
	var aux_t = global_transform
	parent.remove_child(self)
	grandpa.add_child(self)
	self.global_transform = aux_t 
	self.velocity = parent_owner.velocity
#	grabbed = false

func _physics_process(delta: float) -> void:
#	if !grabbed:
	velocity = move_and_slide(velocity)
	velocity.y += weight*delta

