class_name UnlockComponent
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is MainKame && PlayerGlobals.key_count > 0:
		SignalHub.key_used.emit()
		SignalHub.change_key_count.emit(PlayerGlobals.key_count)
		SignalHub.check_point.emit(get_parent().global_position)
		get_parent().queue_free()
