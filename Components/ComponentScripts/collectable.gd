class_name Collectable
extends Area2D

var signal_bus: Dictionary = {
	"OneUp" : SignalHub.one_up_collected,
	"Key" : SignalHub.key_collected
}


func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		check_parent()


func check_parent() -> void:
	var parent := get_parent()
	match parent.name:
		"OneUp":
			var signal_to_emit = signal_bus.get(parent.name)
			if !signal_to_emit:
				push_warning("\nsignal_to_emit is Null check signal bus Dictionary and %s." % parent.name)
				parent.queue_free()
				return

			PlayerGlobals.players_lives +=1
			var new_count: int = PlayerGlobals.players_lives
			signal_to_emit.emit(new_count)
			print("picked up a one up")
			parent.queue_free()
		"Key" :
			print("picked up a key")
			parent.queue_free()