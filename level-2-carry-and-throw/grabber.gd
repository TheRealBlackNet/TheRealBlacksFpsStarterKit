extends Node3D
class_name grabber

@export var handPos:Node3D
@onready var raycast:RayCast3D = %RayCast3D

var handIsEmpty:bool = true
var itemInHand:PickupableInterface = null
var throwForce : float = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	if handIsEmpty:
		handIsEmpty = false
		itemInHand = item
		itemInHand.pickedUp()
		item.reparent(handPos,false)
		item.position = Vector3(0,0,0)
		item.rotation = Vector3(0,0,0)

