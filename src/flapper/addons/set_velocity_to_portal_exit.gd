extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	yield(owner,"ready")
	owner.velocity = Global.exit_portal_velocity
