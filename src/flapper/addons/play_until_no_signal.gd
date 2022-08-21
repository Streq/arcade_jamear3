extends AudioStreamPlayer2D

var keep_playing = false

var power = 0.0
export var min_power = 0.0
export var max_power = 10.0
export var min_volume = -80.0
export var max_volume = 0.0

func trigger(applied_friction):
#	var threshold_squared = owner.graze_threshold*owner.graze_threshold
	
	power = range_lerp(applied_friction, min_power, max_power, min_volume, max_volume)
	power = clamp(self.power, min_volume, max_volume)
	
	keep_playing = true

func _physics_process(delta):
	if keep_playing:
		if !playing:
			playing = true
		volume_db = power
	else:
		playing = false
	keep_playing = false
	
