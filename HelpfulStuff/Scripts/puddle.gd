extends Node2D



func enter_puddle(body: Node2D) -> void:
	SignalHub.entered_puddle.emit()


func exit_puddle(body: Node2D) -> void:
	SignalHub.exited_puddle.emit()
