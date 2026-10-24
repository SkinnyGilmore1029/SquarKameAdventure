class_name TreasureCollectable
extends Area2D

@export var treasure_data: PointTemplate


func _on_body_entered(body: Node2D) -> void:
	if body is MainKame:
		check_treasure()

# TODO: Add a dictionary to pull points data from
# TODO: Finish check_treasure
# TODO: Rethink signals


func check_treasure() -> void:
	print("%s are worth ->  %d" % [treasure_data.treasure_name, treasure_data.point_value])
	get_parent().queue_free()