class_name Collectable
extends Area2D

var signal_bus: Dictionary = {
	"OneUp" : SignalHub.one_up_collected,
	"Key" : SignalHub.key_collected
}


func _on_body_entered(body: Node2D) -> void:
	check_parent(get_parent())


func check_parent(parent: Node2D) -> void:
	match parent.name:
		"OneUp":
			print("picked up a one up")
			parent.queue_free()
		"Key" :
			print("picked up a key")
			parent.queue_free()