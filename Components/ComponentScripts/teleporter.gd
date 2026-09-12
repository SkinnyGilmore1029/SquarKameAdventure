class_name Teleporter
extends Node2D

var grandparent = get_parent()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		print(grandparent)
		LevelChange.call_deferred("change_level","Level2", Vector2(160,768))
