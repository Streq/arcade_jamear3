extends State
#OVERRIDABLE

export var NODE : PackedScene

var node

# Initialize the state. E.g. change the animation
func _enter(params):
	node = NODE.instance()
	node.app_state_node = self
	get_tree().current_scene.add_child(node)
	get_tree().paused = false

# Clean up the state. Reinitialize values like a timer
func _exit():
	get_tree().current_scene.remove_child(node)
	node.free()
	get_tree().paused = false
	
# Awake the state from suspension. E.g. Readd nodes to tree
func _awaken():
#	get_tree().current_scene.add_child(node)
	get_tree().paused = false
	
# Suspend the state. E.g. Remove nodes
func _suspend():
	get_tree().paused = true

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	return

# Called during _input
func _handle_input(event: InputEvent):
	return

