extends Node2D


func _ready() -> void:
	set_level()

func set_level()->void:
	SignalHub.start_hot_bar.emit(100)
