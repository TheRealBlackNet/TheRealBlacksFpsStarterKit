extends SwitchAble
class_name Door

@onready var door_start = %DoorStart
@onready var door_end = %DoorEnd
@onready var door = %Door
@onready var timer_close_door = $TimerCloseDoor


var tween:Tween

var doorType:DT = DT.AutoClose

enum DT{
	AutoClose,
	RemoteClose,
	SlowClose,
	BROKEN
}

func _ready():
	for sb:SwitchBase in switchList:
		if sb.type == SwitchBase.ButtonType.SWITCH:
			doorType = DT.RemoteClose
		elif sb.type == SwitchBase.ButtonType.HOLD_BUTTON:
			doorType = DT.SlowClose
		elif sb.type == SwitchBase.ButtonType.BUTTON:
			doorType = DT.AutoClose
		else:
			doorType = DT.BROKEN
	
	print("ME: " + name + " -- " + str(doorType)\
			+ " --- " + str(switchList.size()))
	
		

func switchedOn():
	if not self.moving:
		self.moving = true
		tween = create_tween()
		tween.tween_property(door, "position", door_end.position, 1.5)
		if doorType == DT.AutoClose:
			tween.finished.connect(doneOpenAutoClose)
		else:
			tween.finished.connect(doneOpenManualClose)
			setPushed(true)
		
		setWait(true)
		tween.play()


func switchedOff():
	if not self.moving and doorType == DT.RemoteClose:
		self.moving = true
		setWait(true)
		tween = create_tween()
		tween.tween_property(door, "position", door_start.position, 1.5)
		tween.finished.connect(doneClose)
		tween.play()
		setPushed(false)

func doneOpenManualClose():
	setWait(false)
	self.moving = false

func doneOpenAutoClose():
	timer_close_door.start(2.0)

func doneClose():
	self.moving = false
	setWait(false)

func setWait(on:bool):
	for sb:SwitchBase in switchList:
		sb.isWaiting = on

func setPushed(on:bool):
	for sb:SwitchBase in switchList:
		sb.isPressed = on


func _on_timer_close_door_timeout():
	var a:Area3D = $Area3D
	if a.has_overlapping_areas():
		timer_close_door.start(0.5)
	else:
		self.moving = true
		tween = create_tween()
		tween.tween_property(door, "position", door_start.position, 1.5)
		tween.finished.connect(doneClose)
		tween.play()
