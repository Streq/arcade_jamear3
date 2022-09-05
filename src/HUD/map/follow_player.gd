extends Camera2D

var _remote

var player

func set_to(player):
	if !is_instance_valid(_remote):
		_remote = RemoteTransform2D.new()
	if player:
		var parent = _remote.get_parent()
		if parent:
			parent.remove_child(_remote)
		
		_remote.remote_path = get_path()
		player.add_child(_remote)

func _exit_tree():
	if is_instance_valid(_remote):
		_remote.queue_free()
