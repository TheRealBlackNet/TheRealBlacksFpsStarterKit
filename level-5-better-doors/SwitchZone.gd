extends SwitchBase
class_name SwitchZone

@onready var timer:Timer = %Timer
@export var isWaiting:bool = false


func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		switchAble.switchedOn()
		timer.stop()


func _on_area_3d_body_exited(body):
	if body is CharacterBody3D:
		timer.start()


func _on_timer_timeout():
	if not switchAble.moving:
		switchAble.switchedOff()
		timer.stop()
