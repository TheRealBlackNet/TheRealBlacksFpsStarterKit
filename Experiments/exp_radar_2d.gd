extends Node2D


@onready var char: CharacterBody2D = %Char
@onready var echo: CollisionShape2D = %ECHO

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func get_input():
	var input_direction = Input.get_vector("left", "right", "forward", "backward")
	char.velocity = input_direction * 200
	if Input.is_action_just_pressed("jump"):
		makeEcho()
	
	if Input.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://main-menu/main.tscn")

func _physics_process(delta):
	get_input()
	char.move_and_slide()

func _on_button_button_up() -> void:
	makeEcho()

func makeEcho() -> void:
	# MAKE ECHO
	var shape:CircleShape2D = echo.shape
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(shape, "radius", 500, 2)
	tween.tween_callback(resetEcho)

func resetEcho():
	var shape:CircleShape2D = echo.shape
	shape.radius = 10
