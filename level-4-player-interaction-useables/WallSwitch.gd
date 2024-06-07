extends Node3D
class_name WallSwitch

@export_category("Button Options")
@export var type:ButtonType = ButtonType.BUTTON

@export var isLocked:bool = false
@export var isPressed:bool = false

@onready var timeOutSpam = %TimeOutSpam
@onready var timerAnim = %TimerAnim

@onready var red = %Red
@onready var green = %Green
@onready var blue = %Blue
@onready var white = %White
@onready var black = %Black
@onready var yellow = %Yellow

var spam_shield:bool = false
var animStep = 4


enum ButtonType {
	BUTTON, # click anim\send reset
	HOLD_BUTTON, # click - let go
	SWITCH, # toggle on off
	DISABLED # gray off
}

signal switchOn(sender:Node3D)
signal switchOff(sender:Node3D)


func _ready():
	if type == ButtonType.HOLD_BUTTON:
		isPressed = false
	setfinalColor()

func _on_time_out_timeout():
	spam_shield = false

func letGo():
	if type == ButtonType.HOLD_BUTTON:
		allOff()
		white.show()
		Audio.force_sound("/kenney_CC/metalClick.ogg", 0.0, -5)
		switchOff.emit(self)

func tryUse() -> bool:
	var is_used_now = false
	if not spam_shield:
		spam_shield = true
		timeOutSpam.start(0.75)
		if type != ButtonType.DISABLED:
			if isLocked:
				Audio.force_sound("/kenney_CC/zapThreeToneDown.ogg", 0.0, -20)
				startAnimation()
			else:
				if type == ButtonType.BUTTON:
					startAnimation()
				elif type == ButtonType.HOLD_BUTTON:
					allOff()
					green.show()
					isPressed = true
				elif type == ButtonType.SWITCH:
					isPressed = !isPressed
					startAnimation()
				# ###
				Audio.force_sound("/kenney_CC/threeTone1.ogg", 0.0, -18)
				is_used_now = true
		else:
			allOff()
			black.show()
	# else
	return is_used_now

func allOff():
	red.hide()
	green.hide()
	blue.hide()
	white.hide()
	black.hide()
	yellow.hide()

func setfinalColor():
	allOff()
	if isLocked:
		red.show()
	elif type == ButtonType.DISABLED:
		black.show()
	elif type == ButtonType.BUTTON:
		yellow.show()
	elif type == ButtonType.HOLD_BUTTON:
		white.show()
	elif type == ButtonType.SWITCH:
		if isPressed:
			green.show()
		else:
			red.show()

func startAnimation():
	animStep = 4
	timerAnim.stop()
	timerAnim.start(0.25/2.0)

func _on_timer_anim_timeout():
	allOff()
	if animStep <= 0:
		timerAnim.stop()
		setfinalColor()
		switchOn.emit(self)
	elif animStep % 2 == 0:
		if type == ButtonType.BUTTON:
			yellow.show()
		else: 
			white.show()
	else:
		if type == ButtonType.BUTTON:
			white.show()
		else: 
			black.show()
	# #####
	animStep -= 1












