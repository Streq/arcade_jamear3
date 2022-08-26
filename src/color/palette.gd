extends Node
tool

export var palette: PoolColorArray setget set_palette
export var material : ShaderMaterial

var ready = false

var tex = ImageTexture.new()

func _ready():
	ready = true
	set_palette(palette)
	var m : ShaderMaterial = material
	m.set_shader_param("palette", tex)
	get_parent().material = material

func set_palette(val):
	palette = val
	if ready:
		update_tex_from_palette()

func update_tex_from_palette():
	var size = palette.size()
	if size:
		var img = Image.new()
		img.create(size, 1, false, Image.FORMAT_RGBA8)
		img.lock()
		for i in size:
			img.set_pixel(i%size, i/size, palette[i])
		img.unlock()
		update_tex(img)
	
func update_tex(img):
	tex.flags = -1
	tex.create_from_image(img)
	tex.flags = 0
