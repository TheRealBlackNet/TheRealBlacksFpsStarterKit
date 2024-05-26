extends RigidBody3D
class_name PickupableInterface

@onready var collider:CollisionShape3D = %Collider

@export var fillingColor:FillableBox.FillingType = FillableBox.FillingType.Clear

# a counter 
var fellOutOfWorld:int = 0
# used in animations to avoid to be a tween effected 
# item to be picked up
var canBeUsed:bool = true

func pickedUp():
	collider.disabled = true
	canBeUsed = false
	freeze = true

func throwen():
	collider.disabled = false
	canBeUsed = true
	freeze = false

func dropped():
	collider.disabled = false
	canBeUsed = true
	freeze = false

func _physics_process(delta):
	# fall under the map
	if global_position.y < -40:
		fellOutOfWorld += 1
		linear_velocity = Vector3(0,0,0)
		set_axis_velocity(Vector3(0,0,0))
		global_position.y = 10
		
		if fellOutOfWorld > 5:
			global_position.x = 0
			global_position.z = 0
		
		if fellOutOfWorld > 15:
			self.queue_free()
