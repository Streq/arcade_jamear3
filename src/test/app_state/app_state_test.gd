extends Node2D


onready var state_machine = $state_machine


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.initialize()


func _physics_process(delta):
	state_machine.physics_update(delta)
	state_machine._process_queue()
	
