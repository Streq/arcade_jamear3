extends Camera2D

func _physics_process(delta):
	pass
#	position += get_parent().velocity * delta

func _on_portal(portal):
	NodeUtils.reparent_keep_transform(self, portal)

func _ready():
	get_parent().connect("entered_portal", self, "_on_portal")
