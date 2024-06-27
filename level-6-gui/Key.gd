@tool
extends CenterContainer
class_name AnimatedKey

signal clicked(key:AnimatedKey, char:String)

@onready var button:Button = %button


@export_category("KeyOptions")
@export var normalCol:KEYCOL = KEYCOL.blue:
	set(val):
		normalCol = val
		init()
	get:
		return normalCol
		
@export var pressedCol:KEYCOL = KEYCOL.yellow:
	set(val):
		pressedCol = val
		init()
	get:
		return pressedCol
		
@export var keyvale:String = "X":
	set(val):
		keyvale = val
		if button != null:
			button.text = val
			# makeShortCut() DID NOT WORK
	get:
		return keyvale
	

@onready var bg_blue:NinePatchRect = %BG_Blue
@onready var bg_green:NinePatchRect = %BG_Green
@onready var bg_white:NinePatchRect = %BG_White
@onready var bg_red:NinePatchRect = %BG_Red
@onready var bg_yellow:NinePatchRect = %BG_Yellow

@onready var arrayElements:Array=[bg_blue,\
	bg_green, bg_white, bg_red, bg_yellow]

enum KEYCOL{
	blue,
	green,
	white,
	red,
	yellow
}

func ctok(col:KEYCOL)  -> NinePatchRect:
	if col == KEYCOL.blue:
		return %BG_Blue
	elif col == KEYCOL.green:
		return %BG_Green
	elif col == KEYCOL.white:
		return %BG_White
	elif col == KEYCOL.red:
		return %BG_Red
	else:
		return %BG_Yellow

var isPressed:bool:
	set(val):
		if val:
			ctok(normalCol).hide()
			ctok(pressedCol).show()
		else:
			ctok(pressedCol).hide()
			ctok(normalCol).show()
		isPressed = val
	get:
		return isPressed

func _ready():
	init()

func init():
	for x:NinePatchRect in arrayElements:
		x.hide()
	isPressed = false
	keyvale = keyvale




func _on_btn_button_down():
	isPressed = true

func _on_btn_button_up():
	isPressed = false
	clicked.emit(self, keyvale)

func do_Press(val:bool):
	if val:
		_on_btn_button_down()
	else:
		_on_btn_button_up()



func makeShortCut():
	var sc:Shortcut = Shortcut.new()
	var iek:InputEventKey = InputEventKey.new()
	#
	# ERROR - DON'T WORK ???
	#
	if button.text.length() == 1:
		iek.keycode = OS.find_keycode_from_string(button.text)
		iek.physical_keycode = OS.find_keycode_from_string(button.text)
		iek.key_label = OS.find_keycode_from_string(button.text)
		iek.set_pressed(true)
		sc.events.append(iek)
		button.set_shortcut_in_tooltip(false)
		#button.shortcut = sc
		if sc.has_valid_event():
			pass #print("A + " + button.text)
		else:
			pass #print("B + " + button.text)
