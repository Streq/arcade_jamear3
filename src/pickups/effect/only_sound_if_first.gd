extends AudioStreamPlayer2D

export var group := ""

onready var db = volume_db
func _ready() -> void:
	connect("finished",self,"_on_finished")
	am_playing = playing
	_check()
func _physics_process(delta: float) -> void:
	_check()

var am_playing = false

func _check():
	if am_playing:
		if !is_in_group(group):
			add_to_group(group)
		var sounds = Group.get_all(group)
		var is_first = sounds[0] == self
		if is_first:
			volume_db = db
		else:
			volume_db = -80.0
	elif is_in_group(group):
		remove_from_group(group)

func play(default := 0.0):
	if group == "magic_seed_sound":
		breakpoint
	am_playing = true
	_check()
	.play()
	
func _on_finished():
	am_playing = false
