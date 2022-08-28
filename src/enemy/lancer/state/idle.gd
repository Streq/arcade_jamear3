extends State
onready var timer = $Timer
onready var hearing = $"../../hearing"

func _enter(params):
	owner.animation_player.play("idle")
	timer.start()
	hearing.connect("heard", self, "_on_hearing_heard")

func _exit():
	timer.stop()
	hearing.disconnect("heard", self, "_on_hearing_heard")

func _on_hearing_heard(target):
	timer.start()


func _physics_update(delta: float):
	if owner.sight.can_see(owner.target):
		owner.aim.aim_at(owner.target)
		goto("load")
	
func _on_Timer_timeout():
	goto("asleep")
