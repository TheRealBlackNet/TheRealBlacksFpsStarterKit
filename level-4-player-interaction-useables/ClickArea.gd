extends UseableInterface
class_name ClickArea

@onready var parent:WallSwitch = $"..";

var is_used_now:bool = false

func use():
	is_used_now = parent.tryUse()

func _on_area_exited(area):
	if is_used_now:
		letgo()

func _input(event):
	if Input.is_action_just_released("use")\
		and is_used_now:
		letgo()

func letgo():
	is_used_now = false
	parent.letGo()
