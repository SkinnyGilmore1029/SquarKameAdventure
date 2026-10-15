class_name TheButtons
extends Node2D

@onready var picture: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

var parent_node: Node2D

var SignalBook: Dictionary[int, Signal] = {
	2 : SignalHub.button_pushed_level2,
	5 : SignalHub.button_pushed_level5
}

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		picture.play("Pushed")
		AudioBus.play_sound("Buttons")
		$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
		area_2d.set_deferred("monitoring", false)
		_handle_signals()

func _handle_signals() -> void:
	parent_node = get_parent()
	match GameState.current_level:
		2:
			SignalBook[2].emit(self, parent_node)
		5:
			SignalBook[5].emit(self, parent_node)
		_:
			return