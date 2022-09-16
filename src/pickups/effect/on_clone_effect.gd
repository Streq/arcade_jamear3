extends Node
var GUN
func _ready():
	yield(owner,"ready")
	GUN = load(owner.filename)

func apply(flapper:Node2D):
	_instance(flapper)

func _instance(flapper:Node2D):
	var gun = GUN.instance()
	gun.pre_ready(flapper)
	flapper.pivot.call_deferred("add_child",gun)
	gun.set_deferred("owner",flapper)
