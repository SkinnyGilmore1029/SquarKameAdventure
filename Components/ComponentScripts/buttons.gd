class_name TheButtons
extends Node2D

@onready var picture: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		picture.play("Pushed")
		$Area2D/CollisionPolygon2D.set_deferred("disabled", true)
		area_2d.set_deferred("monitoring", false)
		SignalHub.button_pushed_level2.emit(self, get_parent())

