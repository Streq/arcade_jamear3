extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var collision_shape_2d = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var params = Physics2DShapeQueryParameters.new()
	params.set_shape(collision_shape_2d.shape)
	params.transform = collision_shape_2d.global_transform
	params.collision_layer = 1
	params.collide_with_bodies = false
	params.collide_with_areas = true
	params.exclude = [self]
	var space_state = get_world_2d().direct_space_state
	var query_results = space_state.intersect_shape(params)
	if query_results.size()==2:
		var a = query_results[0].collider.get_parent()
		var b = query_results[1].collider.get_parent()
		a.link_with(b)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
