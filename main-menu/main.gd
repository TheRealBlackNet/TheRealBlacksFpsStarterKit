extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_level_1_button_up():
	get_tree().change_scene_to_file("res://level-1-basicmovement/level-1.tscn")

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
	