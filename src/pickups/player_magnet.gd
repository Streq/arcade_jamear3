extends Area2D

func _physics_process(delta):
	var players = get_overlapping_areas()
	if players:
		var player = players[0]
		var dist :Vector2 = player.global_position-owner.global_position
		var attraction = 100000.0/dist.length_squared()
		owner.global_position = owner.global_position.move_toward(player.global_position,attraction*delta) 
