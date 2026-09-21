class_name Collectable
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		check_parent()

## Nested Dictionary Keys [Name, UI_Signal, Has Args, Args, BackgroundSignal][br]
## Last three might be false, null, null
var node_hub: Dictionary = {
	Keys : {
		"Name" : "Key",
		"UI_Signal" : SignalHub.change_key_count,
		"Has Args" : true,
		"Args" : [PlayerGlobals, "key_count"],
		"BackgroundSignal" : SignalHub.key_collected,
	},
	OneUps: {
		"Name" : "OneUps",
		"UI_Signal" : SignalHub.one_up_collected,
		"Has Args" : true,
		"Args" : [PlayerGlobals, "players_lives"],
		"BackgroundSignal" : SignalHub.one_up_global
	}
}

## Validates the Collectable and emits the configured Signals accordingly.
func check_parent() -> void:
	# Get the parent script/class.
	var parent: Script = get_parent().get_script()

	# Check to make sure the parent is in the Dictionary.
	if parent not in node_hub:
		push_warning("Parent Node %s not in node_hub in collectable.gd." % parent)
		return

	# Make sure the nested dictionary is not empty.
	if len(node_hub.get(parent)) == 0:
		push_warning("No data for %s" % parent)
		return

	# Get the parent's configuration.
	var collectable_data = node_hub.get(parent)

	# Get the configured name and signal.
	var collectable_name = collectable_data.get("Name")
	var collectable_signal = collectable_data.get("UI_Signal")

	# If the signal needs no arguments, emit it and free the collectable.
	if !collectable_data.get("Has Args"):
		collectable_signal.emit()
		get_parent().queue_free()
		return

	# Get the argument array.
	var the_args = collectable_data["Args"]

	# Check the array before accessing its elements.
	if the_args == null or the_args.size() < 2:
		push_warning("%s does not have any Args in its array. check collectable.gd" % collectable_name)
		get_parent().queue_free()
		return

	# Emit the UI signal if one is configured.
	if collectable_data.get("BackgroundSignal") != null:
		collectable_data.get("BackgroundSignal").emit()


	# Get the argument source and property name.
	var argument_source = the_args[0]
	var argument_name = the_args[1]
	var make_argument = argument_source.get(argument_name)

	#Emit the signal with the arguments.
	collectable_signal.emit(make_argument)

	# Free the collectable.
	get_parent().queue_free()
