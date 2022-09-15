class_name Math


static func angle_distance(from:float,to:float):
	return fposmod(to-from + PI, TAU) - PI

static func move_toward_angle(from: float, to: float, amount: float) -> float:
	var result = move_toward(from, from + angle_distance(from, to), amount)
	return result
