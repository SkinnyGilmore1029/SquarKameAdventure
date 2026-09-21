class_name Locks
extends Node2D

func _ready() -> void:
    SignalHub.check_point.connect(check_point_reached)

func check_point_reached(parent_pos: Vector2) -> void:
    PlayerGlobals.spawn_position = parent_pos