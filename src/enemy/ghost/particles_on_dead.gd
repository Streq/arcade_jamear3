extends Node

export var PARTICLES : PackedScene
export var material_owner_path : NodePath

onready var material_owner = get_node(material_owner_path)

var emitted = false
func trigger(by = null):
	trigger_velocity(owner.velocity*3)
	

func trigger_velocity(velocity):
	if !emitted:
		var particles = PARTICLES.instance()
		particles.velocity = velocity.length()
		particles.direction = velocity
		particles.material = material_owner.material
		owner.get_parent().add_child(particles)
		particles.global_position = owner.global_position
#		particles.global_rotation = owner.velocity.angle()
		emitted = true
	 
