class_name Teleporter
extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is MainKame:
		var current_level = get_parent().get_parent()
		var next_level_data = current_level.level_data
		var next_level_int = next_level_data.send_to_level
		var next_level_spawn = next_level_data.spawn_in_level_at
		LevelChange.call_deferred("change_level", next_level_int , next_level_spawn)
