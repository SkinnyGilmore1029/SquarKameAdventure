extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if PlayerGlobals.key_count == 0:
		return
	SignalHub.key_used.emit()
	get_parent().queue_free()
