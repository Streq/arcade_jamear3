extends AudioStreamPlayer2D

var keep_playing = false
var power = 0.0
var min_power = 0.0
var max_power = 10.0
func trigger(applied_friction):
#	var threshold_squared = owner.graze_threshold*owner.graze_threshold
	
	power = range_lerp(applied_friction, min_power, max_power, -10.0, 0.0)
	power = clamp(self.power, -10.0, -1.0)
	
	keep_playing = true

func _physics_process(delta):
	if keep_playing:
		if !playing:
			playing = true
		volume_db = power
	else:
		playing = false
	keep_playing = false
	
