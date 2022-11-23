extends Node2D
onready var sprite = $Sprite
onready var position_2d = $road_maker/Position2D

func _ready():
	sprite.node_position = position_2d
	sprite.position = position_2d.position
