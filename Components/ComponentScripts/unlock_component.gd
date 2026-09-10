class_name UnlockComponent
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if PlayerGlobals.key_count == 0:
		return
	SignalHub.key_used.emit()
	SignalHub.check_point.emit(get_parent().global_position)
	get_parent().queue_free()
