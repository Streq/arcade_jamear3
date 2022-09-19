extends Sprite

export var radius := 10.0


func update_position(vector:Vector2):
	print(vector)
	position = vector*radius
	

func _physics_process(delta: float) -> void:
	update_position(Input.get_vector("ui_left","ui_right","ui_up","ui_down"))
