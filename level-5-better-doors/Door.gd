extends Node3D
class_name Door

@onready var door_start = %DoorStart
@onready var door_end = %DoorEnd
@onready var door = %Door
@onready var timer_close_door = $TimerCloseDoor

var moving:bool = false
var tween:Tween

var switchList:Array = []

func openDoor():
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
	var a:Area3D = $Area3D
	if a.has_overlapping_areas():
		timer_close_door.start(0.5)
	else:
		moving = true
		tween = create_tween()
		tween.tween_property(door, "position", door_start.position, 1.5).from(64)
		tween.finished.connect(doneClose)
		tween.play()
