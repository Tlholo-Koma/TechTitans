extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var time_remaining = get_parent().get_parent().get_node("GameTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(time_remaining.get_time_left())
