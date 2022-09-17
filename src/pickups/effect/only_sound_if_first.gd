extends AudioStreamPlayer2D

export var group := ""

onready var db = volume_db
func _ready() -> void:
	_check()
func _physics_process(delta: float) -> void:
	_check()

func _check():
	if playing:
		if !is_in_group(group):
			add_to_group(group)
		var is_first = Group.get_all(group)[0] == self
		if is_first:
			volume_db = db
		else:
			volume_db = -80.0
	elif is_in_group(group):
		remove_from_group(group)
