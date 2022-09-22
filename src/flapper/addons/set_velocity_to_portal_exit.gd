extends Node

export var disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !disabled:
		yield(owner,"ready")
		owner.velocity = Global.exit_portal_velocity
