extends Node3D
class_name SwitchBase

signal switchOn(sender:Node3D)
signal switchOff(Wsender:Node3D)

func tryUse() -> bool:
	print_debug("SwitchBase OVERLOAD tryUse!")
	return true

func letGo():
	print_debug("SwitchBase OVERLOAD letGo!")
	pass

