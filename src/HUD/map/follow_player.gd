extends Camera2D

var _remote

var player

func _ready():
	player = Group.get_all("flapper")[-1]
	if player:
		_remote.remote_path = get_path()
		player.add_child(_remote)

func _enter_tree():
	_remote = RemoteTransform2D.new()
func _exit_tree():
	if is_instance_valid(_remote):
		_remote.queue_free()
