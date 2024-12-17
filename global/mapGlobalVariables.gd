extends Node
class_name MapGlobalVariables
# see GlobalVariables in Autoload settings


# node to drop Pickupable back.
# made global so the map need to set this node
# and not player have to give this to the hands.
var worldPickupableDropZone:Node3D
var playerWithGui:PlayerBase = null
var keypad:KeyPadBase = null
var mode:GameMode = GameMode.Play

#called by map:
func setWorldPickupableDropZone(node:Node3D) -> void:
	worldPickupableDropZone = node

#called in grabber\player
func getWorldPickupableDropZone() -> Node3D:
	return worldPickupableDropZone

func setKeypad(player:PlayerBase) -> void:
	playerWithGui = player
	if player is Player4:
		keypad = (player as Player4).key_pad_menue
	

func getKeypad() -> KeyPadBase:
	return keypad

enum GameMode{
	Play,
	GUI,
	Free
}

func setFreeMouseMode() -> void:
	mode = GameMode.Free
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func setGuiMode() -> void:
	mode = GameMode.GUI
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func setPlayMode() -> void:
	mode = GameMode.Play
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
