class_name TreasureCollectable
extends Area2D

@export var treasure_data: PointTemplate


func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		_check_treasure()


func _check_treasure() -> void:
	_add_to_current_points()
	get_parent().queue_free()

func _get_current_score() -> int:
	return PlayerGlobals.current_score

func _add_to_current_points() -> void:
	var current: int = _get_current_score()

	var point_value: int = treasure_data.point_value

	if point_value == null or point_value == 0:
		SignalHub.points_collected.emit(current)
		push_warning("%s <-- has no point value set!" % treasure_data.name)
		return

	#have to update the score before showing the score on the UI.
	SignalHub.update_current_score.emit(point_value)

	#use the PlayerGlobals.current_score to keep everything synced.
	SignalHub.points_collected.emit(_get_current_score())
