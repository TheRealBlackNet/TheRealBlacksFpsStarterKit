extends Node3D
class_name DoorWithSwitchTest

@onready var door_start = %DoorStart
@onready var door_end = %DoorEnd
@onready var door = %Door
@onready var timer_close_door = $TimerCloseDoor

var moving:bool = false
var tween:Tween

func _ready():
	pass

func _on_wall_switch_switch_off(sender):
	pass

func _on_wall_switch_switch_on(sender):
	if not moving:
		moving = true
		tween = create_tween()
		tween.tween_property(door, "position", door_end.position, 1.5).from(64)
		tween.finished.connect(doneOpen)
		tween.play()

func doneOpen():
	#moving = false
	timer_close_door.start(2.0)

func doneClose():
	moving = false


func _on_timer_close_door_timeout():
		moving = true
		tween = create_tween()
		tween.tween_property(door, "position", door_start.position, 1.5).from(64)
		tween.finished.connect(doneClose)
		tween.play()
