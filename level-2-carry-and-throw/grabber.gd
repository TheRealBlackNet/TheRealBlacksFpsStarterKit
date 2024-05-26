extends Node3D
class_name grabber

#
# Object to pickup a instance of PickupableInterface from 
# the world and throw or place it back into it.
# This could be part of the player script but its long
#

# object holding in hand
@export var handPos:Node3D
# pointer to find object
@onready var raycast:RayCast3D = %RayCast3D

var handIsEmpty:bool = true
var itemInHand:PickupableInterface = null
var throwForce:float = 5

var snap_into_hand:bool = false

func _input(event):
	if Input.is_action_just_pressed("drop_item"):
		if !handIsEmpty and itemInHand != null:
			releaseItem(itemInHand,false)
	
	if Input.is_action_just_pressed("use"):
		if !handIsEmpty and itemInHand != null:
			releaseItem(itemInHand,true)
		else:
			raycast.force_raycast_update()
			if raycast.is_colliding(): 
				var collider:Object = raycast.get_collider()
				var collision_point:Vector3 = raycast.get_collision_point()
				var origin:Vector3 = raycast.global_transform.origin
				var distance:float = origin.distance_to(collision_point)
				
				if collider is PickupableInterface:
					pickupItem(collider)

func releaseItem(item:PickupableInterface, throwIt:bool):
	if !handIsEmpty:
		item.reparent(GlobalVariables.getWorldPickupableDropZone(),true)
		itemInHand.dropped()
		if throwIt:
			itemInHand.apply_central_impulse(\
				-global_transform.basis.z * throwForce)
		handIsEmpty = true
		itemInHand = null

func pickupItem(item:PickupableInterface):
	if handIsEmpty and item.canBeUsed:
		handIsEmpty = false
		itemInHand = item
		itemInHand.pickedUp()
		if snap_into_hand:
			# snaps items into your hand
			item.reparent(handPos,false)
			item.position = Vector3(0,0,0)
			item.rotation = Vector3(0,0,0)
		else:
			# place items nice into your hand and rotate it
			item.reparent(handPos,true)
			var tween = get_tree().create_tween()
			tween.parallel()
			tween.tween_property(item, "position", Vector3(0,0,0), 0.25)
			tween.parallel()
			tween.tween_property(item, "rotation", Vector3(0,0,0), 0.125)
			tween.play()
