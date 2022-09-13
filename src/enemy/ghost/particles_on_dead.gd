extends Node

export var PARTICLES : PackedScene
export var material_owner_path : NodePath

onready var material_owner = get_node(material_owner_path)

var emitted = false
func trigger():
	if !emitted:
		var particles = PARTICLES.instance()
		owner.get_parent().add_child(particles)
		particles.global_position = owner.global_position
		particles.global_rotation = owner.velocity.angle()
		particles.material = material_owner.material
		emitted = true
