extends Node2D
class_name EchoElement

@onready var reset_echo_timer: Timer = %resetEchoTimer
@onready var sprite_2d: Sprite2D = %Eye
@onready var area_2d: Area2D = %Area2D

func _ready() -> void:
	sprite_2d.hide()

func _on_reset_echo_timer_timeout() -> void:
	sprite_2d.hide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	sprite_2d.show()
	reset_echo_timer.start()
