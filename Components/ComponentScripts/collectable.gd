class_name Collectable
extends Area2D

var signal_bus: Dictionary = {
	"OneUp" : SignalHub.one_up_collected,
	"Key" : SignalHub.key_collected
}


func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		check_parent()

##Pushes a warning if the key is null in the signal bus dictionary.
##Frees the parent node.
func my_warning(parent: Node2D) -> void:
	push_warning("\nsignal_to_emit is Null check signal bus Dictionary and %s." % parent.name)
	parent.queue_free()

func strip_number_from_parent(parent: Node2D) -> String:
	if parent is Keys:
		return "Key"

	elif parent is OneUps:
		return "OneUp"
	else:
		return ""

func check_parent() -> void:
	var parent := get_parent()
	var parent_name = strip_number_from_parent(parent)
	match parent_name:
		"OneUp":
			#get the signal to emit out of the dictionary with parent_name
			var signal_to_emit = signal_bus.get(parent_name)

			#check to make sure the signal to emit is not null.
			if !signal_to_emit:
				my_warning(parent)
				return

			# Add the One Up to the players live count.
			SignalHub.one_up_global.emit()

			#Use the new life count to emit to the hud.
			signal_to_emit.emit(PlayerGlobals.players_lives)

			parent.queue_free()
		"Key" :
			#get the signal to emit out of the dictionary with parent_name
			var signal_to_emit = signal_bus.get(parent_name)

			#check to make sure the signal to emit is not null.
			if !signal_to_emit:
				my_warning(parent)
				return

			signal_to_emit.emit()

			parent.queue_free()