extends CanvasItem
tool

export var palette: PoolColorArray setget set_palette

var ready = false

var tex = ImageTexture.new()

func _ready():
	ready = true
#	material = material.duplicate()
	set_palette(palette)
	var m : ShaderMaterial = material
	m.set_shader_param("palette", tex)
	

func set_palette(val):
	palette = val
	if ready:
		update_tex()

func update_tex():
	tex.flags = -1

	var img = Image.new()
	var size = palette.size()
	img.create(size, 1, false, Image.FORMAT_RGBA8)
	img.lock()
	for i in size:
		img.set_pixel(i%size, i/size, palette[i])
	img.unlock()
	tex.create_from_image(img)
	tex.flags = 0

