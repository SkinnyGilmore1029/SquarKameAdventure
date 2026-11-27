extends Node2D

var rotation_speed: float

func _process(delta: float) -> void:
	rotation += rotation_speed * delta