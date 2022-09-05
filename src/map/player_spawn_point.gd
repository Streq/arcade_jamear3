extends Position2D
onready var camera = $camera

func spawn(player):
	get_parent().add_child(player)
	player.global_position = self.global_position
	camera.follow(player)
	
