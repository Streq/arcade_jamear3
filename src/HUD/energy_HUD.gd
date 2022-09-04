extends CanvasLayer
onready var energy_bar = $energy_bar

func set_player(player):
	track_energy(player.addons["energy"])

func track_energy(energy):
	energy.connect("value_changed",energy_bar,"update_values")
	energy_bar.update_values(energy.value, energy.max_value)
	
func look_for_player():
	set_player(Group.get_one("flapper"))
