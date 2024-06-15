extends Node3D
class_name SwitchAble

var switchList:Array = []
var moving:bool = false

func add_switch(switch:SwitchBase):
	switchList.append(switch)

func switchedOn():
	pass

func switchedOff():
	pass

