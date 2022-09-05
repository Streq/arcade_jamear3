extends Node

export var source_node : NodePath
export var source_property : String
export var dest_node : NodePath
export var dest_property : String

export var source_min_val := 0.0
export var source_max_val := 0.0
export var dest_min_val := 0.0
export var dest_max_val := 0.0


onready var source = get_node(source_node)
onready var source_path = NodePath(source_property)
onready var dest = get_node(dest_node)
onready var dest_path = NodePath(dest_property)


func trigger():
	var val = range_lerp(source.get_indexed(source_path), source_min_val, source_max_val, dest_min_val, dest_max_val)
	var clamped = clamp(val, dest_min_val, dest_max_val)
	dest.set_indexed(dest_path, clamped)
	
func trigger_params(a=null,b=null,c=null,d=null,e=null,f=null,g=null):
	trigger()
