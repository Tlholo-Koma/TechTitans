extends Area

signal coinCollected

onready var timer = get_parent().get_parent().get_parent().get_node("GameTimer")

func _ready():
	pass

func _physics_process(delta):
	#delta ensures below functions are called 60 times per second
	rotate_y(deg2rad(3))

func _on_coin_body_entered(body):
	if body.name == "MainPlayer":
		print("HIT FOR SOME REASON")
		$AnimationPlayer.play("bounce")
		var current_time = timer.get_time_left()
		timer.start(current_time + 5)
		$Timer.start()
		
		
func _on_Timer_timeout():
	emit_signal("coinCollected")
	queue_free()   #remove coin from screen
