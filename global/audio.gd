extends Node
# do not play more then 12 sounds at a time:
var num_players:int = 12
var bus:String = "Master"

var available:Array = []
var queue:Array = []

func _ready():
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.volume_db = -10
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func play(sound_path:Array): 
	# plays a random sound from the array.
	var sound = sound_path[randi() % sound_path.size()]
	queue.append("res://" + sound.strip_edges())

func _process(_delta):
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		# make more variantes by pitching it a bit:
		available[0].pitch_scale = randf_range(0.9, 1.1)
		available.pop_front()

func _on_stream_finished(stream):
	# add the player back to the array:
	available.append(stream)
