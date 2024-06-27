extends Node2D
class_name KeyPad1

@export_category("KeyPad Options")
@export var codeSize = 4
@export var result:String = "----"
@export var elementActive = true:
	get:
		return elementActive
	set(val):
		elementActive = val
		if elementActive:
			clearCode()
			self.show()
		else:
			self.hide()

@onready var label_display = %LabelDisplay

signal codeMatch(sender:KeyPad1)
signal codeError(sender:KeyPad1)

@onready var k_1 = %K1
@onready var k_2 = %K2
@onready var k_3 = %K3
@onready var k_4 = %K4
@onready var k_5 = %K5
@onready var k_6 = %K6
@onready var k_7 = %K7
@onready var k_8 = %K8
@onready var k_9 = %K9
@onready var k_clear = %KClear
@onready var k_0 = %K0
@onready var k_enter = %KEnter

var currentCode:String = "":
	set(val):
		currentCode = val
		label_display.text = currentCode
	get:
		return currentCode

func _ready():
	label_display.text = "";

var lastKey;
func _input(event):
	var curKey;
	if event is InputEventKey:
		if event.keycode == KEY_1\
			or event.keycode == KEY_KP_1:
			curKey = k_1
		elif event.keycode == KEY_2\
			or event.keycode == KEY_KP_2:
			curKey = k_2
		elif event.keycode == KEY_3\
			or event.keycode == KEY_KP_3:
			curKey = k_3
		elif event.keycode == KEY_4\
			or event.keycode == KEY_KP_4:
			curKey = k_4
		elif event.keycode == KEY_5\
			or event.keycode == KEY_KP_5:
			curKey = k_5
		elif event.keycode == KEY_6\
			or event.keycode == KEY_KP_6:
			curKey = k_6
		elif event.keycode == KEY_7\
			or event.keycode == KEY_KP_7:
			curKey = k_7
		elif event.keycode == KEY_8\
			or event.keycode == KEY_KP_8:
			curKey = k_8
		elif event.keycode == KEY_9\
			or event.keycode == KEY_KP_9:
			curKey = k_9
		elif event.keycode == KEY_0\
			or event.keycode == KEY_KP_0:
			curKey = k_0
		elif event.keycode == KEY_ENTER\
			or event.keycode == KEY_KP_ENTER:
			curKey = k_enter
		elif event.keycode == KEY_C\
			or event.keycode == KEY_KP_ADD:
			curKey = k_clear
		#
		#
		if curKey != null:
			curKey.do_Press(event.pressed)
			lastKey = curKey # save last key
			# if a key is released its ok
			if event.pressed == false: 
				lastKey = null
		# if a other key is pressed relase the current key
		elif lastKey != null:
			lastKey.do_Press(false)
			lastKey = null


func _on_number_clicked(key, char):
	if elementActive:
		if currentCode.length() >= codeSize:
			checkCode()
		else:
			currentCode = currentCode + char

func _on_clear_clicked(key, char):
	clearCode()

func _on_enter_clicked(key, char):
	checkCode()

func checkCode():
	if elementActive:
		if currentCode == result:
			codeMatch.emit(self)
		else:
			currentCode = ""
			codeError.emit(self)

func clearCode():
	currentCode = ""
