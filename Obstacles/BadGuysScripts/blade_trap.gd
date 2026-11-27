extends Node2D

@onready var center_point: Node2D = %CenterPoint

var speed_choices: Array[float] = [-3.0, -2.0, -4.0, 4.0, 2.0, 3.0]

func _ready() -> void:
	var rotation_speed_choice: float = speed_choices.pick_random()
	center_point.rotation_speed = rotation_speed_choice

func _on_timer_timeout() -> void:
	var rotation_speed_choice: float = speed_choices.pick_random()
	center_point.rotation_speed = rotation_speed_choice
	center_point.get_node("Timer").start()
