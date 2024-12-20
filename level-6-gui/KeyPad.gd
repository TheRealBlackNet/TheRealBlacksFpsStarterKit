extends KeyPadBase
class_name KeyPad

@onready var label_display = %LabelDisplay

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

func setCurrentCode(text):
	label_display.text = currentCode

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
