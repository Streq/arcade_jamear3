extends Node2D
tool
signal finished
signal start

export var velocity := 0.0
export var direction := Vector2()

onready var base_particle = $"particles/0"
onready var particles = $particles

func _on_0_finished():
	emit_signal("finished")
	queue_free()

func start():
	for particle in particles.get_children():
		var p : CPUParticles2D = particle
		p.direction = direction
		p.initial_velocity = velocity
		p.start()
	emit_signal("start")

func _ready():
	start()
