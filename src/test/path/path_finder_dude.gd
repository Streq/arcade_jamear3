extends Node2D
onready var agent = $NavigationAgent2D
onready var line_2d = $Line2D
var path = PoolVector2Array()
var target = null
func _ready():
	agent.connect("velocity_computed",self,"_on_velocity_computed")

func _physics_process(delta):
#	navigation_agent_2d.set_target_location(get_global_mouse_position())
	var current_pos = global_position
	if get_tree().has_group("flapper"):
		target = Group.get_one("flapper")
		var target_pos = target.global_position
		
#		agent.set_velocity(get_parent().velocity)
		
		path = Navigation2DServer.map_get_path(agent.get_navigation_map(),current_pos,target_pos,true)
	#	navigation_agent_2d.set_navigation_map(maps[0])
	#	var path = navigation_agent_2d.get_nav_path()
#		agent.get_final_location()
		line_2d.clear_points()
		for point in path:
			line_2d.add_point(to_local(point))
		if path.size() and "dir" in get_parent():
			get_parent().dir = (path[1]-path[0]).normalized()
		
