extends SwitchBase
class_name Switch

@export_category("Button Options")

@export var isLocked:bool = false
@export var isWaiting:bool = false:
	set (value):
		isWaiting = value
		setfinalColor()
	get:
		return isWaiting

@onready var timeOutSpam = %TimeOutSpam
@onready var timerAnim = %TimerAnim

@onready var red = %Red
@onready var green = %Green
@onready var blue = %Blue
@onready var white = %White
@onready var black = %Black
@onready var yellow = %Yellow

func init():
	if type == ButtonType.HOLD_BUTTON:
		self.isPressed = false
	setfinalColor()

func _on_time_out_timeout():
	spam_shield = false

func letGo():
	if type == ButtonType.HOLD_BUTTON:
		self.isPressed = false
		setfinalColor()
		Audio.force_sound("/kenney_CC/metalClick.ogg", 0.0, -5)
		switchAble.switchedOff()

func tryUse() -> bool:
	var is_used_now = false
	if not spam_shield and not isWaiting:
		spam_shield = true
		timeOutSpam.start(0.75)
		if type != ButtonType.DISABLED:
			if isLocked:
				Audio.force_sound("/kenney_CC/zapThreeToneDown.ogg", 0.0, -20)
				setfinalColor()
			else:
				if type == ButtonType.BUTTON:
					isWaiting = true
				elif type == ButtonType.HOLD_BUTTON:
					allOff()
					self.isPressed = true
					yellow.show()
				elif type == ButtonType.SWITCH:
					self.isPressed = !self.isPressed
				
				setfinalColor()
				# ###
				Audio.force_sound("/kenney_CC/threeTone1.ogg", 0.0, -18)
				is_used_now = true
				
				if type == ButtonType.SWITCH:
					if self.isPressed:
						switchAble.switchedOn()
					else:
						switchAble.switchedOff()
				else:
					switchAble.switchedOn()
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
	elif isWaiting:
		yellow.show()
	elif type == ButtonType.DISABLED:
		black.show()
	elif type == ButtonType.BUTTON:
		green.show()
	elif type == ButtonType.HOLD_BUTTON:
		if self.isPressed:
			yellow.show()
		else:
			green.show()
	elif type == ButtonType.SWITCH:
		if self.isPressed:
			green.show()
		else:
			red.show()
