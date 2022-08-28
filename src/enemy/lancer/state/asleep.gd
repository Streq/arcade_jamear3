extends State

onready var hearing = $"../../hearing"

# Initialize the state. E.g. change the animation
func _enter(params):
	owner.animation_player.play("asleep")
	hearing.connect("heard", self, "_on_hearing_heard")

func _exit():
	hearing.disconnect("heard", self, "_on_hearing_heard")


func _on_hearing_heard(target):
	owner.target = target
	goto("wake_up")
	
