extends Node
tool

export var palette: PoolColorArray setget set_palette
export var material : ShaderMaterial
export var glow = false setget set_glow
export var glow_speed = 1.0
var ready = false


var tex = ImageTexture.new()


func _ready():
	ready = true
	set_palette(palette)
	material.set_shader_param("palette", tex)
	material.set_shader_param("palette_size", palette.size())
	update_parent_material()
	set_glow(glow)
	

func update_parent_material():
	var parent = get_parent()
	if "material" in parent:
		parent.material = material

func set_palette(val):
	palette = val
	if ready:
		update_tex_from_palette()
		
		material.set_shader_param("palette_size", palette.size())
		property_list_changed_notify()

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

func _process(delta):
	if glow:
		material.set_shader_param("offset", posmod(Time.get_ticks_msec()*glow_speed, 1000)/(1000/palette.size()))
	pass
func set_glow(val):
	glow = val
	if ready:
		material.set_shader_param("offset", 0)
	
