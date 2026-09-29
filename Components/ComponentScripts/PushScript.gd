class_name ThePushable
extends Area2D

var slow_down: Dictionary[Script, float] = {
	PushLogs : 115.0,
	PushRock : 90.0,
	OfferingBody : 115.0
}

var parent_script: Script


func _ready() -> void:
	parent_script = get_parent().get_script()

func is_valid_pushable() -> bool:
	if parent_script not in slow_down:
		push_warning("Pushable %s not in slow_down Dictionary in PushScript.gd" % parent_script.name)
		return false
	return true

func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		if !is_valid_pushable():
			return
		PlayerGlobals.speed = slow_down[parent_script]


func _on_body_exited(body: Node2D) -> void:
	if body is MainKame:
		PlayerGlobals.speed = PlayerGlobals.default_speed
