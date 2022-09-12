extends Node2D

signal shoot(wearer)
signal been_shot()

var wearer

func _ready():
	if !("addons" in wearer):
		yield(wearer,"ready")
	if wearer.addons.has("gun"):
		wearer.addons["gun"].queue_free()
	wearer.addons["gun"] = self
	wearer.connect("flapped", self, "shoot")

func pre_ready(wearer):
	self.wearer = wearer

func shoot():
	emit_signal("shoot",wearer)
#	wearer.velocity += Vector2.UP.rotated(global_rotation)*100
	emit_signal("been_shot")
	
