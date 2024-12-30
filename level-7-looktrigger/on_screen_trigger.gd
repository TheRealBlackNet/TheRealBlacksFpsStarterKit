@icon("res://icons/OnScreenTrigger.svg")
@tool
extends TriggerBase
class_name OnScreenTrigger

@onready var on_screen: VisibleOnScreenNotifier3D = %OnScreen
@onready var ray: RayCast3D = %RayCast3D
@onready var arm: SpringArm3D = %SpringArm3D

@onready var debug_ray: CSGTorus3D = $RayCast3D/DEBUG_RAY
@onready var debug_arm: CSGCylinder3D = $SpringArm3D/DEBUG_ARM
@onready var timer: Timer = %Timer


var triggered:bool = false
@export_category("OnScreenTrigger")
@export
var activated:bool = false

@export_category("OnScreenTriggerSize")
@export_range(0.0, 10.0, 0.05)
var w:float = 1.0:
	get:
		return on_screen.aabb.size.x
	set(value):
		w = value
		updateOnScreen()

@export_range(0.0, 10.0, 0.05)
var h:float = 1.0:
	get:
		return on_screen.aabb.size.y
	set(value):
		h = value
		updateOnScreen()

@export_range(0.0, 10.0, 0.05)
var d:float = 1.0:
	get:
		return on_screen.aabb.size.z
	set(value):
		d = value
		updateOnScreen()

@export_category("TriggerTiming")
@export_range(0.0, 110.0, 0.25)
var outerBound:float = 75.0
@export_range(0.0, 110.0, 0.25)
var innerBound:float = 50.0
@export_range(0.0, 110.0, 0.25)
var instantBound:float = 25.0

@export_range(0.0, 20.0, 0.25, "in seconds")
var slowReactTime:float = 3.0
@export_range(0.0, 20.0, 0.25, "in seconds")
var quickReactTime:float = 1.5

signal triggerOnScreen(sender:OnScreenTrigger)
signal triggerOffScreen(sender:OnScreenTrigger)

var isInViewPort:bool = false
var slowStart: bool = false
var fastStart: bool = false

func _ready() -> void:
	updateOnScreen()

func activate() -> void:
	activated = true

func _on_screen_screen_entered() -> void:
	isInViewPort = true
	triggerOnScreen.emit(self)

func _on_screen_screen_exited() -> void:
	isInViewPort = false
	triggerOffScreen.emit(self)

func updateOnScreen() -> void:
	if on_screen != null:
		on_screen.aabb.size.y = h 
		on_screen.aabb.size.x = w
		on_screen.aabb.size.z = d 
		on_screen.aabb.position = -on_screen.aabb.size / 2.0

func _on_timer_timeout() -> void:
	activated = false
	triggered = true
	timer.stop()
	slowStart = false
	fastStart = false
	triggerFired.emit(self)

func reset() -> void:
	slowStart = false
	fastStart = false
	triggered = false
	activated = false


func _process(delta: float) -> void:
	if activated and isInViewPort and !triggered:
		var cam:Camera3D = get_viewport().get_camera_3d()
		ray.look_at(cam.global_position - Vector3(0.0, 0.0, 0.0),
			Vector3.UP, false)
		arm.look_at(cam.global_position - Vector3(0.0, 0.25, 0.0))
		ray.force_raycast_update()

		if ray.is_colliding():
			debug_ray.global_position = ray.get_collision_point()
			if ray.get_collider().name == "Player":
				
				var view:Viewport = get_viewport()
				# 0,0 to 1080,720 pixel:
				var vec:Vector2 = view.get_camera_3d()\
					.unproject_position(self.global_position)
				# 0 to 1 with 0.5 as mid point -0.5 0,0 as mid
				var normed = Vector2(\
					vec.x / view.size.x - 0.5, 
					vec.y / view.size.y - 0.5) * 2.0
				#print("MEEP: " + str(normed.length()))
				var lenght = normed.length() * 100.0
				
				if lenght <= instantBound:
					triggered = true
					print("START INSTANT")
					timer.stop()
					_on_timer_timeout()
				elif lenght <= innerBound \
						and !fastStart:
					if timer.time_left > quickReactTime \
						or timer.time_left == 0:
						fastStart = true
						print("START FAST")
						timer.stop()
						timer.one_shot = true
						timer.start(quickReactTime)
				elif lenght <= outerBound \
						and !slowStart:
					if timer.time_left > slowReactTime \
						or timer.time_left == 0:
						print("START SLOW")
						slowStart = true
						timer.stop()
						timer.one_shot = true
						timer.start(slowReactTime)
						
				print("TEST "\
					+ str(timer.time_left)\
					+ " OUT: " + str(slowStart)\
					+ " IN: " + str(fastStart)\
					+ " T: " + str(triggered)\
					)
