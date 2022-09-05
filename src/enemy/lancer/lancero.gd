extends KinematicBody2D

onready var state_machine = $state_machine
onready var animation_player = $AnimationPlayer
onready var palette = $palette
onready var shooter = $aim/shooter
onready var sight = $sight
onready var aim = $aim
onready var exclamation_anim = $exclamation_anim
export var difficulty = 0.0

var target = null

func _ready():
	target = Group.get_one("flapper")
	state_machine.initialize()

func _physics_process(delta):
	if get_tree().has_group("flapper"):
		target = Group.get_one("flapper")
	state_machine.physics_update(delta)
	animation_player.advance(delta)
