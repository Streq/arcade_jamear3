extends Node

func _ready():
	yield(owner,"ready")
	owner.wearer.connect("seed_taken",self,"_on_seed_taken")

onready var energy = get_parent()
func _on_seed_taken():
	energy.value = energy.max_value
