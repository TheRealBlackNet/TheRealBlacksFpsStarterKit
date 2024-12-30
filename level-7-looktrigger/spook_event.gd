extends Node3D
class_name SpookEvent

var trigger:TriggerBase
var activate:ActivateAble

func _ready() -> void:
	for kid in get_children():
		if kid is TriggerBase:
			trigger = kid
		if kid is ActivateAble:
			activate = kid
	
	if trigger == null or activate == null:
		printerr("Event not able. Needs two kids.")
	else:
		trigger.triggerFired.connect(_on_trigger_fired)
		activate.resetted.connect(_on_activate_resetted)


func _on_trigger_fired(sender:TriggerBase):
	activate.activate()

func _on_activate_resetted(sender:ActivateAble):
	pass # trigger.activate()


func reset():
	trigger.reset()
	activate.reset()
	trigger.activate()
