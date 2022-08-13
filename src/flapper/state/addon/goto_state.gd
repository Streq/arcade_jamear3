extends Node

export var state := ""

var root:State


func trigger():
	root.goto(state)
