extends Node2D

signal shoot(wearer)
signal been_shot()
signal remove()
var wearer

export var weapon_name := ""

export var affected_addons := PoolStringArray(["weapon", "weapon2"])
func stacks_with(weapon)->bool:
	return weapon == weapon_name

func _ready():
	if !("addons" in wearer):
		yield(wearer,"ready")
	
	#get weapon list
	var prev_weapons = []
	for w in affected_addons:
		if wearer.addons.has(w):
			prev_weapons.append(wearer.addons[w])
	
	if !prev_weapons.empty():
		if prev_weapons[0].stacks_with(self.weapon_name):
			if prev_weapons.size()==2:#replace secondary
				prev_weapons[1].remove()
			
			#add as secondary
			for w in affected_addons:
				if !wearer.addons.has(w):
					wearer.addons[w] = self
					if w == affected_addons[1]:
						rotation = PI
						position -= position*2
			
			wearer.connect("pre_flap", self, "shoot")
			
				
		else:#replace all
			for weapon in prev_weapons:
				weapon.remove()
			wearer.addons[affected_addons[0]] = self
			wearer.connect("pre_flap", self, "shoot")
	else:#add normally
		wearer.addons[affected_addons[0]] = self
		wearer.connect("pre_flap", self, "shoot")
	
	


func pre_ready(wearer):
	self.wearer = wearer

func remove():
	emit_signal("remove")
	for w in ["weapon","weapon2"]:
		if wearer.addons.has(w) and wearer.addons[w] == self:
			wearer.addons.erase(w)
	queue_free()

func shoot():
	emit_signal("shoot",wearer)
#	wearer.velocity += Vector2.UP.rotated(global_rotation)*100
	emit_signal("been_shot")
	
