extends AudioStreamPlayer3D
class_name FootStepPlayer

@onready var player = %AudioStreamPlayer3D

var sounds:Array=[]

func _ready():
	# start a randomizer in the background:
	randomize()
	# repare a array of preloaded sounds to play while walking
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
	
	# play the fist sound and pause the stream
	# because the player will stand still first
	player.stream=sounds.front()
	player.play()
	player.autoplay = true
	player.stream_paused = true

func hold():
	player.stream_paused = true

func go():
	player.stream_paused = false

func sounds_random(s:Array) -> void:
	# resort the sounds in the array and play them:
	s.shuffle()
	player.stream=sounds.front()
	player.play()

func _on_AudioStreamPlayer_finished():
	# play the next sound wenn the fist step is finished.
	sounds_random(sounds)
