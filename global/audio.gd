extends Node
# do not play more then 12 sounds at a time:
var num_players:int = 12
var bus:String = "Master"

var available:Array = []
var queue:Array = []

func _ready() -> void:
	for i in num_players:
		var p:AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.volume_db = -15
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus

func play_single(sound_path:String) -> void: 
	queue.append("res://" + sound_path.strip_edges())

func play(sound_path:Array) -> void: 
	# plays a random sound from the array.
	var sound:String = sound_path[randi() % sound_path.size()]
	queue.append("res://" + sound.strip_edges())

func _process(_delta:float) -> void:
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available[0].volume_db = -15
		# make more variantes by pitching it a bit:
		available[0].pitch_scale = randf_range(0.9, 1.1)
		available.pop_front()

func _on_stream_finished(stream:AudioStreamPlayer) -> void:
	# add the player back to the array:
	available.append(stream)


func force_sound(sound_path:String, pitch_win:float, db:int) -> void: 
	var p:AudioStreamPlayer = AudioStreamPlayer.new()
	p.bus = bus
	p.stream = load("res://" + sound_path.strip_edges() )
	p.pitch_scale = randf_range(1-pitch_win, 1+pitch_win)
	p.volume_db = db
	p.finished.connect(_on_stream_finished_forced.bind(p))
	add_child(p)
	p.play()

func _on_stream_finished_forced(stream:AudioStreamPlayer) -> void:
	remove_child(stream)
	stream.queue_free()

