extends Label

export var autoplay := false


export (PoolStringArray) var texts

var text_index = -1
var frame = 0

var frames_to_change = []
func next():
	text_index += 1
	text = texts[text_index]

func _physics_process(delta: float) -> void:
	if playing:
		if frames_to_change.size() == frame_index:
			playing = false
#			yield(get_tree().create_timer(2.0),"timeout")
#			queue_free()
			return
		if frames_to_change[frame_index] == frame:
			next()
			frame_index += 1
	frame += 1

func _unhandled_key_input(event: InputEventKey) -> void:
	if OS.is_debug_build():
		if event.is_pressed():
			match event.scancode:
				KEY_W:
					next()
					record_next()
				KEY_E:
					save_recording()
				KEY_T:
					load_recording()
					play_recording()

func _ready() -> void:
	next()
	if autoplay:
		load_recording()
		play_recording()
	pass

func record_next():
	frames_to_change.push_back(frame)
	
	
const PATH = "res://assets/data/demo_text.dat"
func save_recording():
	var file = File.new()
	file.open(PATH, File.WRITE)
	file.store_var(frames_to_change)
	file.close()
func load_recording():
	var file = File.new()
	file.open(PATH, File.READ)
	frames_to_change = file.get_var()
	file.close()
var playing = false
var frame_index = 0
func play_recording():
	frame = 0
	frame_index = 0
	playing = true
