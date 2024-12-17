extends SwitchBase
class_name WallSwitchGui

@export_category("Button Options")
@export var unlockCode:String = ""

@export var isLocked:bool = false

@onready var timeOutSpam = %TimeOutSpam
@onready var timerAnim = %TimerAnim

@onready var red = %Red
@onready var green = %Green
@onready var blue = %Blue
@onready var white = %White
@onready var black = %Black
@onready var yellow = %Yellow
var animStep = 4

func _ready():
	type = ButtonType.KEYPAD
	setfinalColor()

func _on_time_out_timeout():
	spam_shield = false

func letGo():
	pass

func tryUse() -> bool:
	var is_used_now = false
	if not spam_shield:
		spam_shield = true
		timeOutSpam.start(0.75)
		if type != ButtonType.DISABLED:
			if isLocked:
				Audio.force_sound(\
					"/kenney_CC/zapThreeToneDown.ogg", 0.0, -20)
				startAnimation()
			else:
				if type == ButtonType.KEYPAD:
					startAnimation()
					GlobalVariables.setGuiMode();
					GlobalVariables.getKeypad().show()
					GlobalVariables.getKeypad().elementActive = true
					GlobalVariables.getKeypad().result = unlockCode
					GlobalVariables.getKeypad().codeError
					
					if GlobalVariables.getKeypad()\
							.codeClose.is_connected(_on_codeClose.bind()):
						_on_codeClose(GlobalVariables.getKeypad())
					 
					GlobalVariables.getKeypad().codeClose.connect(_on_codeClose.bind())
					GlobalVariables.getKeypad().codeMatch.connect(_on_codeOk.bind())
					GlobalVariables.getKeypad().codeError.connect(_on_codeFail.bind())
				# ###
				Audio.force_sound(\
					"/kenney_CC/threeTone1.ogg", 0.0, -18)
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
	if type == ButtonType.KEYPAD:
		blue.show()

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
		white.show()
	else: 
		black.show()
	# #####
	animStep -= 1

func _on_codeClose(sender:KeyPad):
	if sender.codeClose.is_connected(_on_codeClose.bind()):
		sender.codeClose.disconnect(_on_codeClose.bind())
	if sender.codeMatch.is_connected(_on_codeOk.bind()):
		sender.codeMatch.disconnect(_on_codeOk.bind())
	if sender.codeError.is_connected(_on_codeFail.bind()):
		sender.codeError.disconnect(_on_codeFail.bind())

func _on_codeOk(sender:KeyPad):
	startAnimation()
	Audio.force_sound(\
		"/kenney_CC/threeTone1.ogg", 0.0, -18)
	GlobalVariables.getKeypad().closeKeypad()
	GlobalVariables.setPlayMode()
	switchAble.switchedOn()
	
	
func _on_codeFail(sender:KeyPad):
	startAnimation()
	Audio.force_sound(\
		"/kenney_CC/zapThreeToneDown.ogg", 0.0, -20)
