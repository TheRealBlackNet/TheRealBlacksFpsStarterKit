extends SwitchAble
class_name Dummy





func _on_timer_timeout():
	for sb:SwitchBase in switchList:
		sb.isWaiting = false
