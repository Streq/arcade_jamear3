extends CanvasLayer
onready var energy_bar = $energy_bar

func track_energy(energy):
	energy.connect("value_changed",energy_bar,"update_values")
	energy_bar.update_values(energy.value, energy.max_value)
	
