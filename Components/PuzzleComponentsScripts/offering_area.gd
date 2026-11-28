extends Area2D

@export var the_taker: StaticBody2D
var script_name: Script


func _on_body_entered(body: Node2D) -> void:
	if body is OfferingBody:
		script_name = the_taker.get_script()
		SignalHub.unpin_joint.emit()
		body.set_deferred("freeze", true)
		set_deferred("monitoring", false)
		SignalHub.can_not_move.emit(body)

		match script_name:
			DaisyWhale:
				SignalHub.has_fruit.emit(the_taker)
				#this just adds to the fruit count to show the key.
				SignalHub.giving_offer.emit()
			MamaKame:
				print("Hello")
			_:
				push_warning("%s <-- has no script" % the_taker.name)
				return
