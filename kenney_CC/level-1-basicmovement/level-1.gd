extends Node3D
class_name Level1

func _ready():
	# keep the mouse in for a FPS game
	# esc will release it a second will return to menue
	# see player script
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
