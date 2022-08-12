class_name Math

	
static func angle_distance(from:float, to:float):
	#keep it within one revolution
	#10-200 = -190
	#difference = -190
	var difference: float = fmod(to - from, TAU)
	#if difference is greater than 180 degrees
	#then I'm closer the other way around
	#fmod(2.0 * difference, TAU) is the difference between the two possible angles 
	#-20 = -190 - (-170)
	var distance: float = fmod(2.0 * difference, TAU) - difference
	return distance
	
static func move_toward_angle(from: float, to: float, amount: float) -> float:
	var result = move_toward(from, from + angle_distance(from, to), amount)
	return result
