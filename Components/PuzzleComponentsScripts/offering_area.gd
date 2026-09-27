extends Area2D

@export var the_taker: StaticBody2D

func _on_body_entered(body: Node2D) -> void:
	if body is OfferingBody:
		body.set_deferred("freeze", true)
		set_deferred("monitoring", false)
		SignalHub.has_fruit.emit(the_taker)
		SignalHub.giving_offer.emit()
