extends AudioStreamPlayer3D
class_name FootStepPlayer

@onready var player = %AudioStreamPlayer3D

var sounds:Array=[]

func _ready():
	randomize()
	
	sounds.append(preload("res://kenney_CC/footstep00.ogg"))
	sounds.append(preload("res://kenney_CC/footstep01.ogg"))
	sounds.append(preload("res://kenney_CC/footstep02.ogg"))
	sounds.append(preload("res://kenney_CC/footstep03.ogg"))
	sounds.append(preload("res://kenney_CC/footstep04.ogg"))
	sounds.append(preload("res://kenney_CC/footstep05.ogg"))
	sounds.append(preload("res://kenney_CC/footstep06.ogg"))
	sounds.append(preload("res://kenney_CC/footstep07.ogg"))
	sounds.append(preload("res://kenney_CC/footstep08.ogg"))
	sounds.append(preload("res://kenney_CC/footstep09.ogg"))
	
	player.stream=sounds.front()
	player.play()
	player.autoplay = true
	player.stream_paused = true

func hold():
	player.stream_paused = true

func go():
	player.stream_paused = false

func sounds_random(s:Array) -> void:
	s.shuffle()
	player.stream=sounds.front()
	player.play()

func _on_AudioStreamPlayer_finished():
	sounds_random(sounds)
