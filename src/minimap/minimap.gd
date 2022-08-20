extends Node2D

export var dotsize = 8.0
export var minimap_scale = 1.0/8.0

func _physics_process(delta):
	update()


func _draw():
	
	var rect = Rect2(0,0,dotsize,dotsize)
	
	var nodes = {
		"ghost":Color.red,
		"bat":Color.rebeccapurple,
		"seed":Color.green,
		"flapper":Color.darkorange,
	}
	
	for key in nodes:
		var color = nodes[key]
		for n in get_tree().get_nodes_in_group(key):
			rect.position = n.global_position*minimap_scale - rect.size/2
			draw_rect(rect, color)
		
