extends ActivateAble
class_name MonsterCutoutNotify

@export_category("scare values")
@onready var mover: Node3D = %Mover
@onready var char_anim: AnimationPlayer = %char_anim
@export var direction:Vector3 = Vector3(-3.0 ,0.0, 0.0)

var executed:bool = false

func activate():
	if !executed:
		executed = true
		var tween:Tween = get_tree().create_tween()
		tween.set_ease(Tween.EaseType.EASE_IN)
		tween.tween_property(mover, "position",\
			direction, 1.5)
		char_anim.play("crouch")
		Audio.force_sound(\
			"kenney_CC/footstep00.ogg",\
			1.0, 1.0)
		activated.emit(self)

func reset():
	mover.position = Vector3(0.0, 0.0, 0.0)
	char_anim.play("static")
	Audio.force_sound(\
		"kenney_CC/metalClick.ogg",\
			1.0, 1.0)
	resetted.emit(self)
	executed = false
