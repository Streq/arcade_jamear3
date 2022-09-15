extends Node2D

signal shoot(wearer)
signal been_shot()
signal remove()

var wearer


func _ready():
	if !("addons" in wearer):
		yield(wearer,"ready")
	if wearer.addons.has("weapon"):
		var prev_weapon = wearer.addons["weapon"]
		prev_weapon.remove()
	wearer.addons["weapon"] = self
	wearer.connect("flapped", self, "shoot")


func pre_ready(wearer):
	self.wearer = wearer

func remove():
	emit_signal("remove")
	if wearer.addons["weapon"] == self:
		wearer.addons.erase("weapon")
	queue_free()

func shoot():
	emit_signal("shoot",wearer)
#	wearer.velocity += Vector2.UP.rotated(global_rotation)*100
	emit_signal("been_shot")
	
