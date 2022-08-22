extends Sprite


var size = Vector2(1,1)
var texture_size = Vector2(1,1)

func _ready():
	size = texture.get_size()/Vector2(hframes,vframes)
func _process(delta):
	var shader : ShaderMaterial = material
	material.set_shader_param("sprite_rect_offset", frame_coords*size)
