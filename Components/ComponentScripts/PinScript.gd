extends Area2D

@export var node_pin: PinJoint2D

func _ready() -> void:
	SignalHub.unpin_joint.connect(_unpin_from_player)


#body_entered Signal.
func pin_to_player(body: Node2D) -> void:
	if body is MainKame:
		node_pin.node_a = body.get_path()
		node_pin.node_b = get_parent().get_path()


func _unpin_from_player() -> void:
	node_pin.node_a = ""
	node_pin.node_b = ""