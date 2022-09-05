extends CanvasLayer
onready var energy_bar = $energy_bar
signal set_to(player)
func set_to(player):
	if player:
		set_player(player)
	emit_signal("set_to",player)

func set_player(player):
	track_energy(player.addons["energy"])

func track_energy(energy):
	if !energy.is_connected("value_changed",energy_bar,"update_values"):
		energy.connect("value_changed",energy_bar,"update_values")
		energy_bar.update_values(energy.value, energy.max_value)
	
