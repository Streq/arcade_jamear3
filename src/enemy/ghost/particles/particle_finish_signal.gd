extends CPUParticles2D
signal finished

func start():
	if not emitting:
		emitting = true
		get_tree()\
			.create_timer(lifetime * (2 - explosiveness), false)\
			.connect("timeout", self, "emit_signal", ["finished"])
