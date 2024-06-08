extends Node3D
class_name Level5

@onready var physics_drop_zone = %PhysicsDropZone

func _ready():
	# keep the mouse in for a FPS game
	# esc will release it a second will return to menue
	# see player script
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# to drop items back into
	GlobalVariables.setWorldPickupableDropZone(physics_drop_zone)

