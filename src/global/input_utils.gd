class_name InputUtils

static func get_input_dir() -> Vector2:
	return Vector2(
		float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")),
		float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	)

static func get_dist_to_mouse(node:CanvasItem) -> Vector2:
	var mouse_viewport_position := node.get_viewport().get_mouse_position()
	var node_viewport_position := node.get_global_transform_with_canvas().origin
	return mouse_viewport_position-node_viewport_position

#accounts for simulated inputs unlike Input.get_vector
static func get_vector(nx : String, px : String, ny : String, py : String, deadzone : float = -1.0) -> Vector2:
	var vector : Vector2 = Vector2(
			Input.get_axis(nx, px),
			Input.get_axis(ny, py)
		).limit_length(1.0)
	
	if deadzone < 0.0:
		deadzone = (
			( InputMap.action_get_deadzone(nx)
			+ InputMap.action_get_deadzone(px)
			+ InputMap.action_get_deadzone(ny)
			+ InputMap.action_get_deadzone(py)
			) * 0.25
		)
	deadzone = clamp(deadzone, 0.0, 1.0)
	
	
	# Circular length limiting and deadzone.
	var length: float = vector.length();
	if length <= deadzone:
		return Vector2()
	elif length > 1.0:
		return vector / length;
	else:
		# Inverse lerp length to map (deadzone, 1) to (0, 1).
		return vector * (inverse_lerp(deadzone, 1.0, length) / length)
