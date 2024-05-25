extends Node
class_name MapGlobalVariables
# see GlobalVariables in Autoload settings


# node to drop Pickupable back.
# made global so the map need to set this node
# and not player have to give this to the hands.
var worldPickupableDropZone:Node3D

#called by map:
func setWorldPickupableDropZone(node:Node3D):
	worldPickupableDropZone = node

#called in grabber\player
func getWorldPickupableDropZone() -> Node3D:
	return worldPickupableDropZone

