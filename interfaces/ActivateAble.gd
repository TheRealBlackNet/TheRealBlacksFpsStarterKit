@icon("res://icons/MonsterCutout.svg")
extends Node3D
class_name ActivateAble

signal activated(sender:ActivateAble)
signal resetted(sender:ActivateAble)

func activate():
	activated.emit(self)

func reset():
	resetted.emit(self)
