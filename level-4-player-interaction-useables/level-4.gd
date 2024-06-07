extends Node3D
class_name Level4

@onready var physics_drop_zone = %PhysicsDropZone

@onready var door_button = %DoorButton
@onready var door_flip_flop = %DoorFlipFlop

func _ready():
	# keep the mouse in for a FPS game
	# esc will release it a second will return to menue
	# see player script
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# to drop items back into
	GlobalVariables.setWorldPickupableDropZone(physics_drop_zone)

func _on_wall_button_switch_on(sender):
	door_button.openDoor()


func _on_wall_flip_flop_switch_off(sender):
	door_flip_flop.closeDoor()


func _on_wall_flip_flop_switch_on(sender):
	door_flip_flop.openDoor()
