extends Node2D

var state = 0
onready var state_change = $state_change


func _ready():
	state_change.play("open")
