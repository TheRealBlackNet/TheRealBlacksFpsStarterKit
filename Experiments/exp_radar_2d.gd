extends Node2D


@onready var char: CharacterBody2D = %Char
@onready var echo: CollisionShape2D = %ECHO

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	# MAKE ECHO
	var shape:CircleShape2D = echo.shape
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(shape, "radius", 500, 2)
	tween.tween_callback(resetEcho)

func resetEcho():
	var shape:CircleShape2D = echo.shape
	shape.radius = 10
