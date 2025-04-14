extends MapInterface
class_name Level8

@onready var outdoors: MapInterface = $"Level-OutDoors"

func _ready():
	# keep the mouse in for a FPS game
	# esc will release it a second will return to menue
	# see player script
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# to drop items back into
	
	GlobalVariables.setWorldPickupableDropZone(\
		outdoors.getPhysicsDropZone())
	GlobalVariables.setKeypad($Player)
	
	
