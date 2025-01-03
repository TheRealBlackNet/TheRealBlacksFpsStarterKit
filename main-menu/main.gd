extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_end_game_button_up():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().quit()

func _on_video_stream_player_finished():
	var player:VideoStreamPlayer = %SplashPlayer
	player.disconnect("finished", _on_video_stream_player_finished)
	player.stream = load("res://splash_screen_loop.ogv")
	player.autoplay = true
	player.loop = true
	player.play()


func _on_level_1_button_up():
	get_tree().change_scene_to_file(\
		"res://level-1-basicmovement/level-1.tscn")

func _on_level_2_button_up():
	get_tree().change_scene_to_file(\
		"res://level-2-carry-and-throw/level-2.tscn")

func _on_level_3_button_up():
	get_tree().change_scene_to_file(\
		"res://level-3-object-events/level-3.tscn")

func _on_level_4_button_up():
	get_tree().change_scene_to_file(\
		"res://level-4-player-interaction-useables/level-4.tscn")

func _on_level_5_button_up():
	get_tree().change_scene_to_file(\
		"res://level-5-better-doors/level-5.tscn")

func _on_level_6_button_up():
	get_tree().change_scene_to_file(\
		"res://level-6-gui/level-6.tscn")

func _on_level_6aui_button_up():
	get_tree().change_scene_to_file(\
		"res://level-6-gui/UIOnly.tscn")    

func _on_level_7_button_up() -> void:
	get_tree().change_scene_to_file(\
		"res://level-7-looktrigger/level-7.tscn")   


func _on_exp_1_radar_2d_button_up() -> void:
	get_tree().change_scene_to_file(\
		"res://Experiments/Exp-Radar2D.tscn") 
