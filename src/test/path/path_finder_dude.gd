extends Sprite
onready var agent = $NavigationAgent2D
onready var line_2d = $Line2D

func _ready():
	agent.connect("velocity_computed",self,"_on_velocity_computed")

func _physics_process(delta):
#	navigation_agent_2d.set_target_location(get_global_mouse_position())
	var current_pos = global_position
	if get_tree().has_group("flapper"):
		var target_pos = get_tree().get_nodes_in_group("flapper")[0].global_position
		
#		agent.set_velocity(get_parent().velocity)
		
		var path = Navigation2DServer.map_get_path(agent.get_navigation_map(),current_pos,target_pos,true)
	#	navigation_agent_2d.set_navigation_map(maps[0])
	#	var path = navigation_agent_2d.get_nav_path()
#		agent.get_final_location()
		line_2d.clear_points()
		for point in path:
			line_2d.add_point(to_local(point))
		if path.size():
			get_parent().dir = (path[1]-path[0]).normalized()
		
func _on_velocity_computed(safe_velocity):
	get_parent().velocity = safe_velocity 
	print (safe_velocity)
