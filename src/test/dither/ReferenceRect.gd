extends ReferenceRect
tool
onready var sprite = $"../Sprite"

func _process(delta):
	rect_position = sprite.rect_position-Vector2(0,1)
	rect_size = sprite.rect_size+Vector2(1,1)

	
