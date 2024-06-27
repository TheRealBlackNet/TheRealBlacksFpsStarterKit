extends Control

@onready var key_pad_1 = $KeyPad1

func _on_key_clicked(key, char:String):
	print("KEY: " + char)

func _on_key_7_show_clicked(key, char):
	key_pad_1.elementActive = true

func _on_key_8_hide_clicked(key, char):
	key_pad_1.elementActive = false

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://main-menu/main.tscn")

func _on_key_pad_1_code_error(sender):
	Audio.play_single("/kenney_CC/phaserDown1.ogg")


func _on_key_pad_1_code_match(sender):
	Audio.play_single("/kenney_CC/tone1.ogg")


func _on_key_9_set_clicked(key, char):
	var x:TextEdit = $TextEdit
	var y:KeyPad1 = $KeyPad1
	y.result = x.text
