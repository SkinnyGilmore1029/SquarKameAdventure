class_name Collectable
extends Area2D

var signal_bus: Dictionary = {
	"OneUp" : SignalHub.one_up_collected,
	"Key" : SignalHub.key_collected
}

var node_types: Dictionary = {
	Keys : ["Key", SignalHub.one_up_collected, SignalHub.one_up_global],
	OneUps : ["OneUp", SignalHub.key_collected]
}

func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		check_parent()

func signal_need_argument(signal_name) -> bool:
	#only loop through my dictionary does not need to know about all signals in Signal
	for signal_data in node_types.values()[1]:
		return signal_data["args"].size() > 0
	return false

##Pushes a warning if the key is null in the signal bus dictionary.
##Frees the parent node.
func my_warning(parent: Node2D) -> void:
	push_warning("\nsignal_to_emit is Null check signal bus Dictionary and %s." % parent.name)
	parent.queue_free()

func get_parents_name(parent: Node2D) -> String:
	if parent.get_script() not in node_types:
		push_warning("Parent Node %s not in node_types in collectables.gd" % parent)
		return ""
	var parent_array = node_types.get(parent.get_script())
	return parent_array[0]
#this is a work in progress got to figure out how to check if it needs an arguments
"""
func check_parent2() -> void:
	#Get the parent node of the collectable type.
	var parent: Node2D = get_parent()

	#check to make sure parent node is in the Dictionary.
	if parent not in node_types:
		push_warning("Parent Node %s not in node_types in collectable.gd." % parent)
		return

	#check to make sure the Array is not empty.
	if len(node_types.get(parent)) <= 1:
		push_warning("Parent Node %s is not complete check node_types in collectable.gd." % parent)
		return

	#Get the name and signal/signals to emit for parent Node2D.
	var node_name = node_types.get(parent)[0]

	if !SignalHub.has_signal(node_types.get(parent)[1]):
		push_warning("This is not a signal %s ." % node_types.get(parent)[1] )
		return
	var signal_to_emit = node_types.get(parent)[1]

	if len(node_types.get(parent)) == 3 && SignalHub.has_signal(node_types.get(parent)[2]):
		var UI_signal = node_types.get(parent)[2]
		UI_signal.emit()
"""



func check_parent() -> void:
	var parent := get_parent()
	var parent_name = get_parents_name(parent)
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