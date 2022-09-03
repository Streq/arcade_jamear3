extends State
#OVERRIDABLE

onready var canvas_layer = $CanvasLayer

func _ready():
	remove_child(canvas_layer)

# Initialize the state. E.g. change the animation
func _enter(params):
	get_tree().current_scene.add_child(canvas_layer)

# Clean up the state. Reinitialize values like a timer
func _exit():
	get_tree().current_scene.remove_child(canvas_layer)
	
# Awake the state from suspension. E.g. Readd nodes to tree
func _awaken():
	get_tree().current_scene.add_child(canvas_layer)

# Suspend the state. E.g. Remove nodes
func _suspend():
	get_tree().current_scene.remove_child(canvas_layer)

# Called during _process
func _update(delta: float):
	return

# Called during _physics_process
func _physics_update(delta: float):
	return

# Called during _input
func _handle_input(event: InputEvent):
	return

