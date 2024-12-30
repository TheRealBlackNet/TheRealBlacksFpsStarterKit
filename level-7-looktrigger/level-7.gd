extends Node3D
class_name Level7

@onready var physics_drop_zone = %PhysicsDropZone

@onready var info_on_screen: CSGMesh3D = %InfoOnScreen
@onready var monster_cutout: MonsterCutoutNotify = %MonsterCutout
@onready var spook_event_1: SpookEvent = %SpookEvent1
@onready var spook_event_2: SpookEvent = %SpookEvent2


func _ready():
	# keep the mouse in for a FPS game
	# esc will release it a second will return to menue
	# see player script
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# to drop items back into
	GlobalVariables.setWorldPickupableDropZone(physics_drop_zone)
	GlobalVariables.setKeypad($Player)

func _on_switch_switch_on(sender: SwitchBase) -> void:
	spook_event_1.reset()

func reset():
	info_on_screen\
		.mesh.material\
		.albedo_color = Color.AQUA

func seen():
	info_on_screen\
		.mesh.material\
		.albedo_color = Color.BROWN


func lost():
	info_on_screen\
		.mesh.material\
		.albedo_color = Color.CHARTREUSE

func _physics_process(delta: float) -> void:
	var cam:Camera3D = %Player.getCam()
	var pos:Vector2 = cam.unproject_position(\
		%MonsterCutout.global_position)
	var size:Vector2 = get_viewport().size

func _on_switch_2_switch_on(sender: SwitchBase) -> void:
	spook_event_2.reset()
