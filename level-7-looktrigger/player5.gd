@icon("res://res/PlayerGui.png")
extends PlayerBase
class_name Player5

const SPEED:float = 5.0
const JUMP_VELOCITY:float = 4.5

# arrays for sound:
const jump_sound_array:Array = [
	"kenney_CC/bookPlace1.ogg",
	"kenney_CC/bookPlace2.ogg",
	"kenney_CC/bookPlace3.ogg"]

const land_sound_array:Array = [
	"kenney_CC/impactMining_000.ogg",
	"kenney_CC/impactMining_001.ogg"]

@onready var footsteps:FootStepPlayer = %AudioStreamPlayer3D
@onready var key_pad_menue:KeyPad = %KeyPadMenue

var gravity:Variant = ProjectSettings.get_setting("physics/3d/default_gravity")
var landed:bool = true

# Extra variables to keep track of mouse movement
var input_mouse:Vector2
var rotation_target:Vector3
var mouse_sensitivity:int = 700
var in_menue:bool = false

func _ready():
	get_tree().get_root().size_changed.connect(resize) 
	resize()
	key_pad_menue.elementActive = false
	GlobalVariables.playerWithGui = self
	

func resize():
	var ch:Node2D = %Crosshair
	ch.position = get_tree().get_root().size / 2
	%MenuMover.position = get_tree().get_root().size / 2


func _physics_process(delta):
	movement(delta)
	look_around(delta)

func _input(event):
	# one esc releases the mouse (good for debugging)
	# a second esc return to the main menu:
	if event.is_action_pressed("esc")\
			and GlobalVariables.mode == GlobalVariables.GameMode.Free:
		get_tree().change_scene_to_file("res://main-menu/main.tscn")
	
	save_mouse_movement(event)
	mouse_capture_game_close()


func look_around(delta:float):
	var camera:Camera3D = %Camera3D
	# Rotation of the camera:
	camera.rotation.z = lerp_angle(camera.rotation.z, -input_mouse.x * 25 * delta, delta * 5)	
	camera.rotation.x = lerp_angle(camera.rotation.x, rotation_target.x, delta * 25)
	rotation.y = lerp_angle(rotation.y, rotation_target.y, delta * 25)


func movement(delta:float):
	# falling:
	if not is_on_floor():
		velocity.y -= gravity * delta
		landed = false;
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		landed = false;
		velocity.y = JUMP_VELOCITY
		Audio.play(jump_sound_array)
	#elif Input.is_action_just_pressed("jump"):
	#	velocity.y = JUMP_VELOCITY
	
	# see the projet setting for the key mapping:
	var input_dir = Input.get_vector(\
		"left", "right", "forward", "backward")
	var direction = (transform.basis\
			* Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		# slow down if there is no direction pressed:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# reset player if falling out of world:
	if position.y <= -40.0:
		position = Vector3(0,10,0)
	
	move_and_slide()
	movement_sound()


func movement_sound():
	# Movement sounds
	if !landed and is_on_floor():
		#just landed play falling sound:
		Audio.play(land_sound_array)
	
	# pause the walking sound.
	footsteps.hold()
	if is_on_floor():
		landed = true; # play walking sound
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			footsteps.go()


func save_mouse_movement(event):
	if event is InputEventMouseMotion\
			and GlobalVariables.mode == GlobalVariables.GameMode.Play:
		input_mouse = event.relative / mouse_sensitivity
		rotation_target.y -= event.relative.x / mouse_sensitivity
		rotation_target.x -= event.relative.y / mouse_sensitivity
	# limit view always from down to up:
	rotation_target.x = clamp(\
		rotation_target.x,\
		deg_to_rad(-90),\
		deg_to_rad(90))


func mouse_capture_game_close():
	# clicked back into the game capture mouse:
	if Input.is_action_just_pressed("shoot")\
			and GlobalVariables.mode == GlobalVariables.GameMode.Free:
		GlobalVariables.setPlayMode()
	
	if Input.is_action_just_pressed("esc")\
			and GlobalVariables.mode == GlobalVariables.GameMode.Play:
		GlobalVariables.setFreeMouseMode()
		input_mouse = Vector2.ZERO

	if Input.is_action_just_pressed("esc")\
			and GlobalVariables.mode == GlobalVariables.GameMode.GUI:
		GlobalVariables.getKeypad().hide()
		GlobalVariables.getKeypad().elementActive = false
		GlobalVariables.setPlayMode()
		input_mouse = Vector2.ZERO


func getCam() -> Camera3D:
	return %Camera3D
