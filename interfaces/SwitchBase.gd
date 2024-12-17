extends Node3D
class_name SwitchBase

signal switchOn(sender:SwitchBase)
signal switchOff(sender:SwitchBase)

@export_category("Button Options")
@export var type:ButtonType = ButtonType.BUTTON
@export var switchAble:SwitchAble
@export var isPressed:bool = false

var spam_shield:bool = false

enum ButtonType {
	BUTTON, # click anim\send reset
	HOLD_BUTTON, # click - let go
	SWITCH, # toggle on off
	KEYPAD, # blue opens menue
	DISABLED # gray off
}


func init():
	pass

func _ready():
	if switchAble == null and type != ButtonType.DISABLED:
		print_debug("SWITCH HAS NOTHING TO CONNECT...")
	else:
		switchAble.add_switch(self)
	init()

func tryUse() -> bool:
	print_debug("SwitchBase OVERLOAD tryUse!")
	return true

func letGo():
	print_debug("SwitchBase OVERLOAD letGo!")
	pass
