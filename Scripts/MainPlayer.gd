extends KinematicBody

export var speed = 5
export var acceleration = 5
export var sensitivity = 0.2
export var max_angle = 90
export var min_angle = -80

onready var camera = $CameraPivot/Camera
onready var footsteps = get_parent().get_node("Footsteps")

var look_rotation = Vector3.ZERO
var movement_direction = Vector3.ZERO
var velocity = Vector3.ZERO
var walking = false

func _ready():
	_on_GameTimer_timeout()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):    
	camera.rotation_degrees.x = look_rotation.x
	rotation_degrees.y = look_rotation.y
	
	movement_direction = Vector3(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	0,
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized().rotated(Vector3.UP, rotation.y)
	
	if movement_direction.x != 0 or movement_direction.z != 0:
		walking = true
	else:
		walking = false

	if walking and !footsteps.playing:
		footsteps.play()

	if not walking and footsteps.playing:
		footsteps.stop()
	
	velocity.x = lerp(velocity.x, movement_direction.x * speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_direction.z * speed, acceleration * delta)
	
	velocity = move_and_slide(velocity)
	

func _on_enemy_body_entered(body):
	if body.name == "MainPlayer":
		get_tree().change_scene("res://Assets/GameOver.tscn")
		
func _input(event):
	if event is InputEventMouseMotion:
		look_rotation.y -= event.relative.x * sensitivity
		look_rotation.x -= event.relative.y * sensitivity
		look_rotation.x = clamp(look_rotation.x, min_angle, max_angle)
		


func _on_GameTimer_timeout():
	# take player to initial position when time runs out
	#translation.x = -0.206
	#translation.y = 2.023
	#translation.z = 0.552
	pass
	
func initialPlayerPosition():
	#translation.x = -0.206
	#translation.y = 2.023
	#translation.z = 0.552
	pass


func _on_DoorArea_body_entered(body):
	if body.name == "MainPlayer":
		get_tree().change_scene("res://Assets/GameOver.tscn") #need to change to porper screen
		print("you win!")
