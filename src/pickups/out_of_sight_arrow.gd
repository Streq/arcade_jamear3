extends VisibilityNotifier2D


onready var arrow = $CanvasLayer/arrow

func _physics_process(delta):
	if !self.is_on_screen():
		update_arrow()
		
func update_arrow():
	var vp_transform = get_viewport_transform()
	
	var screen_dims = get_viewport_rect().size
	var relative_pos = vp_transform.xform(owner.global_position)
	
	var dir = Vector2()

	dir = (relative_pos-screen_dims/2)

	var x = clamp(relative_pos.x, 0, screen_dims.x)
	var y = clamp(relative_pos.y, 0, screen_dims.y)
	
	arrow.rotation = dir.angle()
	arrow.position = Vector2(x,y)

func _on_screen_exited():
	update_arrow()
