extends Node
var num_players = 12
var bus = "master"

var available = []
var queue = []

func _ready():
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)

		available.append(p)

		p.volume_db = -10
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func _on_stream_finished(stream):
	available.append(stream)

func play(sound_path:Array): 
	var sound = sound_path[randi() % sound_path.size()]
	queue.append("res://" + sound.strip_edges())
	#print("PlaySound: " + sound)

func _process(_delta):
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available[0].pitch_scale = randf_range(0.9, 1.1)
		available.pop_front()
